#Requires -Module Pester
<#
.SYNOPSIS
    Pester unit tests for skills/jarvis-playbook-manager/scripts/rebuild-apbx.ps1

.DESCRIPTION
    Tests the rebuild script contract using Pester 3-compatible assertions.
    The runtime tests place a fake 7z.cmd at the front of PATH instead of
    mocking an external executable invoked through the call operator.
#>

$Script:ScriptUnderTest = Resolve-Path "$PSScriptRoot\..\skills\jarvis-playbook-manager\scripts\rebuild-apbx.ps1"
$Script:ProjectRoot = Resolve-Path "$PSScriptRoot\.."
$Script:ScriptText = Get-Content -Path $Script:ScriptUnderTest -Raw

Describe "rebuild-apbx.ps1 contract" {

    It "uses the 05_build wildcard glob as the archive source" {
        $Script:ScriptText | Should Match "Join-Path\s+\`$ProjectRoot\s+'05_build\\\*'"
    }

    It "invokes 7z as a plain command string" {
        $Script:ScriptText | Should Match '\$7zCommand\s*=\s*"7z"'
        $Script:ScriptText | Should Not Match 'Get-Command 7z'
        $Script:ScriptText | Should Not Match '\$7zCommand\.Source'
    }

    It "does not terminate the host process from the catch block" {
        $Script:ScriptText | Should Not Match '(?m)^\s*exit\s+1\s*$'
    }

    It "warns on non-zero 7-Zip exit codes instead of throwing" {
        $Script:ScriptText | Should Match 'Warning: 7-Zip returned exit code'
        $Script:ScriptText | Should Not Match 'throw "7-Zip returned exit code'
    }
}

Describe "rebuild-apbx.ps1 runtime behavior" {

    It "passes the expected archive arguments to 7z" {
        $tempRoot = Join-Path ([System.IO.Path]::GetTempPath()) ([System.Guid]::NewGuid().ToString())
        $fakeBin = Join-Path $tempRoot "bin"
        $argLog = Join-Path $tempRoot "args.txt"
        New-Item -ItemType Directory -Path $fakeBin -Force | Out-Null

        $fake7z = Join-Path $fakeBin "7z.cmd"
        @"
@echo off
echo %* > "$argLog"
exit /b 0
"@ | Set-Content -Path $fake7z -Encoding ASCII

        $oldPath = $env:PATH
        $env:PATH = "$fakeBin;$oldPath"

        try {
            . $Script:ScriptUnderTest
            $argsLine = Get-Content -Path $argLog -Raw

            $argsLine | Should Match '^a '
            $argsLine | Should Match '-t7z'
            $argsLine | Should Match '-pmalte'
            $argsLine | Should Match 'JarvisOS\.apbx'
            $argsLine | Should Match '05_build\\\*'
            $argsLine | Should Match '-y'
        } finally {
            $env:PATH = $oldPath
            Remove-Item -Path $tempRoot -Recurse -Force -ErrorAction SilentlyContinue
        }
    }

    It "does not throw when 7z is unavailable" {
        $tempRoot = Join-Path ([System.IO.Path]::GetTempPath()) ([System.Guid]::NewGuid().ToString())
        New-Item -ItemType Directory -Path $tempRoot -Force | Out-Null

        $oldPath = $env:PATH
        $env:PATH = $tempRoot

        try {
            { . $Script:ScriptUnderTest } | Should Not Throw
        } finally {
            $env:PATH = $oldPath
            Remove-Item -Path $tempRoot -Recurse -Force -ErrorAction SilentlyContinue
        }
    }
}
