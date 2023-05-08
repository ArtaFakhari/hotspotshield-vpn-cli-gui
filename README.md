# Hotspot Shield VPN - on Linux

This is a script for connecting to the Hotspot Shield VPN service in Linux from the command line with a graphical menu.

## Installation

1. Make sure you have Hotspot Shield installed on your system and it's in your PATH.
2. Clone or download this repository to your computer.
3. Open a terminal and navigate to the directory where you saved the script.
4. Make the script executable with the command `chmod +x hotspotshield-vpn.sh`.

## Usage

1. Open a terminal and navigate to the directory where you saved the script.
2. Run the script with the command `./hotspotshield-vpn.sh`.
3. A graphical menu will appear, allowing you to choose an option:
    - Select "Default Location" to connect to the VPN with the default location ("frpar").
    - Select "More Locations" to see a list of available locations and choose one to connect to.
    - Select "Status" to see the current status of the VPN connection.
    - Select "Disconnect" to disconnect from the VPN.
4. Follow the on-screen instructions to proceed with your selection.
5. Press the "Escape" key at any time to return to the main menu.

## Notes

- This script requires Zenity to display the graphical menu. Make sure Zenity is installed on your system.
- Pressing the "Escape" key allows you to exit the script or return to the main menu.
- If you encounter any issues or have any questions, please create an issue on the GitHub repository.

## Contributing

Contributions are welcome! If you have any improvements or bug fixes, feel free to fork the repository and submit a pull request.
