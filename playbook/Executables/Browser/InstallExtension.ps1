# Force-install uBlock Origin via Group Policy (Chrome + Edge)
# uBlock Origin is a trusted open-source ad/tracker blocker.
# Chrome Web Store ID: cjpalhdlnbpafiamejdnhcphjbkeiagm
# Edge Add-ons ID:     odfafepnkmbhccpbejgmiehpchacaeak

$chromeExtId = "cjpalhdlnbpafiamejdnhcphjbkeiagm;https://clients2.google.com/service/update2/crx"
$edgeExtId   = "odfafepnkmbhccpbejgmiehpchacaeak;https://edge.microsoft.com/extensionwebstorebase/v1/crx"

# Chrome Policy
$chromeKey = "HKLM:\SOFTWARE\Policies\Google\Chrome\ExtensionInstallForcelist"
if (-not (Test-Path $chromeKey)) { New-Item -Path $chromeKey -Force | Out-Null }
Set-ItemProperty -Path $chromeKey -Name "1" -Value $chromeExtId

# Edge Policy
$edgeKey = "HKLM:\SOFTWARE\Policies\Microsoft\Edge\ExtensionInstallForcelist"
if (-not (Test-Path $edgeKey)) { New-Item -Path $edgeKey -Force | Out-Null }
Set-ItemProperty -Path $edgeKey -Name "1" -Value $edgeExtId

Write-Host "Privacy extensions (uBlock Origin) installation policies applied."
