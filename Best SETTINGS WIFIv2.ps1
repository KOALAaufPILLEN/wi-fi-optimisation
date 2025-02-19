# Elevate to admin privileges before making any changes
if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
    exit
}

# Common error handling function
function Set-RegistryValue {
    param(
        [string]$Path,
        [string]$Name,
        [object]$Value
    )
    
    try {
        if (Test-Path $Path) {
            Set-ItemProperty -Path $Path -Name $Name -Value $Value -ErrorAction Stop
            Write-Host "Successfully set $Name to $Value"
        } else {
            Write-Warning "Registry path not found: $Path"
        }
    } catch {
        Write-Warning "Failed to set $Name at $Path - $_"
    }
}

# Configure network profile settings
$networkProfilesPath = "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\NetworkList\Profiles"
if (Test-Path $networkProfilesPath) {
    Get-ChildItem $networkProfilesPath | ForEach-Object {
        Set-RegistryValue -Path $_.PSPath -Name "Prefer higher signal strength" -Value 1
        Set-RegistryValue -Path $_.PSPath -Name "Automatically optimize connections" -Value 0
    }
} else {
    Write-Warning "Network profiles registry path not found: $networkProfilesPath"
}

# Configure Wi-Fi adapter advanced settings
try {
    $wifiAdapter = Get-NetAdapter -Physical -ErrorAction Stop | Where-Object { $_.IfType -eq 71 }
    
    if ($wifiAdapter) {
        $interfaceGuid = $wifiAdapter.InterfaceGuid
        $adapterRegistryPath = "HKLM:\SYSTEM\CurrentControlSet\Control\Class\{4D36E972-E325-11CE-BFC1-08002BE10318}\$interfaceGuid"
        
        Set-RegistryValue -Path $adapterRegistryPath -Name "Handoff Threshold" -Value -70
    } else {
        Write-Warning "No Wi-Fi adapters found"
    }
} catch {
    Write-Warning "Error accessing network adapters - $_"
}

# Optional: Restart network services to apply changes
try {
    Restart-Service -Name WlanSvc -ErrorAction Stop
    Write-Host "Wireless services restarted successfully"
} catch {
    Write-Warning "Failed to restart wireless services - $_"
}

Write-Host "Wi-Fi optimization completed"
