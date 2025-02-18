# Load the saved Wi-Fi settings from the file
$wifiSettingsFile = "$env:USERPROFILE\Documents\WiFiSettings.json"
$savedWifiSettings = Get-Content -Path $wifiSettingsFile | ConvertFrom-Json

# Get the Wi-Fi adapter
$wifiAdapter = Get-NetAdapter -Physical | Where-Object {$_.InterfaceGuid -eq $savedWifiSettings.InterfaceGuid}

# Set the "Handoff Threshold" using the .NET Framework
$netAdapter = [System.Net.NetworkInformation.NetworkInterface]::GetAllNetworkInterfaces() | Where-Object {$_.Id -eq $wifiAdapter.InterfaceGuid}
if ($netAdapter -ne $null -and $netAdapter.GetIPProperties().GetIPv4Properties() -ne $null) {
    $netAdapter.GetIPProperties().GetIPv4Properties().HandoffThreshold = $savedWifiSettings.HandoffThreshold
}

# Set the "Prefer higher signal strength" setting
$wifiSettings = (Get-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\NetworkList\Profiles\*" -Name "Prefer higher signal strength")
foreach ($setting in $wifiSettings) {
    Set-ItemProperty -Path $setting.PSPath -Name "Prefer higher signal strength" -Value $savedWifiSettings.PreferHigherSignalStrength
}

# Set the "Automatically optimize connections" setting
$wifiSettings = (Get-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\NetworkList\Profiles\*" -Name "Automatically optimize connections")
foreach ($setting in $wifiSettings) {
    Set-ItemProperty -Path $setting.PSPath -Name "Automatically optimize connections" -Value $savedWifiSettings.AutomaticallyOptimizeConnections
}
