![277316894-401f5135-cf60-4708-8372-48a082dc8003](https://github.com/user-attachments/assets/57214ebe-dde8-46e1-8acb-dbaea11ef0f2)

# Wi-Fi Optimization Script

This PowerShell script is designed to optimize your Windows device's Wi-Fi settings for the best signal strength. It also provides options to load and save your current Wi-Fi settings.

## Features

- **Prefer Higher Signal Strength**: Enables the "Prefer higher signal strength" setting for all Wi-Fi profiles on the system.
- **Disable Automatic Optimization**: Disables the "Automatically optimize connections" setting for all Wi-Fi profiles on the system.
- **Set Handoff Threshold**: Adjusts the "Handoff Threshold" registry value to -70 dBm, which will make the device prefer the higher signal strength connections.
- **Load Current Settings**: The `loading.ps1` script allows you to load your current Wi-Fi settings.
- **Save Current Settings**: The `save.ps1` script allows you to save your current Wi-Fi settings.

## Prerequisites

- Windows operating system
- PowerShell version 5.1 or higher

## Installation

1. Download the `wifi-optimization.ps1`, `loading.ps1`, and `save.ps1` scripts from the repository.
2. Save the scripts to a convenient location on your device.

## Usage

### Optimize Wi-Fi Settings

1. Right-click the `wifi-optimization.ps1` file and select "Run with PowerShell".
2. The script will prompt for administrative privileges if it's not already running as an administrator.
3. Once the script completes, the Wi-Fi settings will be optimized for the best signal strength.

### Load Current Settings

1. Right-click the `loading.ps1` file and select "Run with PowerShell".
2. The script will load your current Wi-Fi settings.

### Save Current Settings

1. Right-click the `save.ps1` file and select "Run with PowerShell".
2. The script will save your current Wi-Fi settings.

## Troubleshooting

If you encounter any issues while running the scripts, please check the following:

1. Ensure that the scripts have the necessary permissions to modify the registry settings.
2. Verify that the PowerShell execution policy is set to allow the scripts to run.
3. Check the error messages displayed in the PowerShell console for more information about the issue.

## Contributing

If you find any bugs or have suggestions for improvements, please feel free to open an issue or submit a pull request on the [GitHub repository](https://github.com/your-username/wifi-optimization-script).

## License

This project is licensed under the [MIT License](LICENSE).
