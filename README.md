# Wi-Fi Optimization Script

This PowerShell script is designed to optimize your Windows device's Wi-Fi settings for the best signal strength.

## Features

- **Prefer Higher Signal Strength**: Enables the "Prefer higher signal strength" setting for all Wi-Fi profiles on the system.
- **Disable Automatic Optimization**: Disables the "Automatically optimize connections" setting for all Wi-Fi profiles on the system.
- **Set Handoff Threshold**: Adjusts the "Handoff Threshold" registry value to -70 dBm, which will make the device prefer the higher signal strength connections.

## Prerequisites

- Windows operating system
- PowerShell version 5.1 or higher

## Installation

1. Download the `wifi-optimization.ps1` script from the repository.
2. Save the script to a convenient location on your device.

## Usage

1. Right-click the `wifi-optimization.ps1` file and select "Run with PowerShell".
2. The script will prompt for administrative privileges if it's not already running as an administrator.
3. Once the script completes, the Wi-Fi settings will be optimized for the best signal strength.

## Troubleshooting

If you encounter any issues while running the script, please check the following:

1. Ensure that the script has the necessary permissions to modify the registry settings.
2. Verify that the PowerShell execution policy is set to allow the script to run.
3. Check the error messages displayed in the PowerShell console for more information about the issue.

## Contributing

If you find any bugs or have suggestions for improvements, please feel free to open an issue or submit a pull request on the [GitHub repository](https://github.com/your-username/wifi-optimization-script).

## License

This project is licensed under the [MIT License](LICENSE).
