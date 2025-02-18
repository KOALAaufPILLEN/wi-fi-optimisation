# Open the "Network & Internet" settings
Start-Process -FilePath "ms-settings:network-wifi"

# Find the "Prefer higher signal strength" setting and turn it on (if it exists)
$wifiSettings = (Get-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\NetworkList\Profiles\*" -Name "Prefer higher signal strength" -ErrorAction SilentlyContinue)
foreach ($setting in $wifiSettings) {
    if ($setting.'Prefer higher signal strength') {
        Set-ItemProperty -Path $setting.PSPath -Name "Prefer higher signal strength" -Value 1
    }
}

# Open the "Network & Internet" settings
Start-Process -FilePath "ms-settings:network-wifi"

# Find the "Automatically optimize connections" setting and turn it off (if it exists)
$wifiSettings = (Get-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\NetworkList\Profiles\*" -Name "Automatically optimize connections" -ErrorAction SilentlyContinue)
foreach ($setting in $wifiSettings) {
    if ($setting.'Automatically optimize connections') {
        Set-ItemProperty -Path $setting.PSPath -Name "Automatically optimize connections" -Value 0
    }
}

# Open the "Network Connections" control panel
Start-Process -FilePath "control" -ArgumentList "ncpa.cpl"

# Find the Wi-Fi adapter and open its properties
$wifiAdapter = Get-NetAdapter -Physical | Where-Object {$_.IfType -eq 71}
$wifiAdapterName = $wifiAdapter.Name
$wifiAdapterPath = "HKLM:\SYSTEM\CurrentControlSet\Control\Class\{4D36E972-E325-11CE-BFC1-08002BE10318}\$($wifiAdapter.InterfaceGuid)"

# Elevate the script to run with administrative privileges
if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    $elevatedScriptPath = [System.IO.Path]::GetTempFileName() + ".ps1"
    $script = $MyInvocation.MyCommand.ScriptBlock
    $script.ToString() | Out-File $elevatedScriptPath
    Start-Process powershell.exe "-File `"$elevatedScriptPath`"" -Verb RunAs
    return
}

# Set the "Handoff Threshold" to -70 dBm
try {
    Set-ItemProperty -Path $wifiAdapterPath -Name "Handoff Threshold" -Value -70
    Write-Host "Wi-Fi settings have been optimized for the best signal strength."
} catch {
    Write-Host "Failed to set the 'Handoff Threshold' registry value. Error: $_"
}