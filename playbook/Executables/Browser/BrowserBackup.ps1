$backupDir = "$env:USERPROFILE\Desktop\JarvisOS_Browser_Backup"
if (-not (Test-Path $backupDir)) {
    New-Item -ItemType Directory -Force -Path $backupDir | Out-Null
}

$browsers = @{
    "Chrome" = "$env:LOCALAPPDATA\Google\Chrome\User Data\Default"
    "Edge"   = "$env:LOCALAPPDATA\Microsoft\Edge\User Data\Default"
}

foreach ($browser in $browsers.GetEnumerator()) {
    $src = $browser.Value
    if (Test-Path $src) {
        $dest = Join-Path $backupDir $browser.Key
        New-Item -ItemType Directory -Force -Path $dest | Out-Null
        
        $filesToBackup = @("Bookmarks", "History", "Login Data")
        foreach ($file in $filesToBackup) {
            $srcFile = Join-Path $src $file
            if (Test-Path $srcFile) {
                Copy-Item -Path $srcFile -Destination $dest -Force
            }
        }
    }
}
Write-Host "Browser backup completed."
