# Get the current Wi-Fi adapter
$wifiAdapter = Get-NetAdapter -Physical | Where-Object {$_.IfType -eq 71}

# Get the current Wi-Fi settings
$wifiSettings = @{
    "InterfaceGuid" = $wifiAdapter.InterfaceGuid
    "SignalStrength" = $wifiAdapter.SignalStrength
    "ReceiveRate" = $wifiAdapter.ReceiveRate
    "TransmitRate" = $wifiAdapter.TransmitRate
    "HandoffThreshold" = $null
    "PreferHigherSignalStrength" = $null
    "AutomaticallyOptimizeConnections" = $null
}

# Retrieve the "Handoff Threshold" value using the .NET Framework
$netAdapter = [System.Net.NetworkInformation.NetworkInterface]::GetAllNetworkInterfaces() | Where-Object {$_.Id -eq $wifiAdapter.InterfaceGuid}
if ($netAdapter -ne $null -and $netAdapter.GetIPProperties().GetIPv4Properties() -ne $null) {
    $wifiSettings["HandoffThreshold"] = $netAdapter.GetIPProperties().GetIPv4Properties().HandoffThreshold
} else {
    $wifiSettings["HandoffThreshold"] = "N/A"
}

# Retrieve the "Prefer higher signal strength" setting
$wifiSettings["PreferHigherSignalStrength"] = (Get-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\NetworkList\Profiles\*" -Name "Prefer higher signal strength")."Prefer higher signal strength"

# Retrieve the "Automatically optimize connections" setting
$wifiSettings["AutomaticallyOptimizeConnections"] = (Get-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\NetworkList\Profiles\*" -Name "Automatically optimize connections")."Automatically optimize connections"

# Save the settings to a file
$wifiSettingsFile = "$env:USERPROFILE\Documents\WiFiSettings.json"
$wifiSettings | ConvertTo-Json | Set-Content -Path $wifiSettingsFile