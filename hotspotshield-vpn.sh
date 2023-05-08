#!/bin/bash

# Check if Hotspot Shield is installed
if ! command -v hotspotshield &>/dev/null; then
    echo "Hotspot Shield is not installed. Please make sure it is installed and in your PATH."
    exit 1
fi

# Function to handle connecting to HotspotShield VPN
function hss_connect() {
    selected_location=$(echo "$selected_item" | awk '{print $1}')

    # Process the selection
    echo "You selected: $selected_item"
    echo "Connecting to $selected_location..."

    # Start HotspotShield VPN
    hotspotshield start
    sleep 2

    # Disconnect from HotspotShield VPN
    hotspotshield disconnect
    sleep 3

    # Connect to the selected option
    hotspotshield connect "$selected_location"
    sleep 5

    # Run hotspotshield status
    hss_status
}

# Function to handle displaying Hotspot Shield status
function hss_status() {
    # Enable non-blocking input
    stty -icanon min 0 time 0

    # Run hotspotshield status every 5 seconds until the user presses Enter or Escape
    while true; do
        clear
        hotspotshield status
        echo "Selected Location: $selected_item"

        echo "Press Escape To Open Main Menu"
        sleep 5

        # Read input without blocking
        key=$(dd bs=1 count=1 2>/dev/null)

        # Check if the user pressed Escape and exit the script if true
        if [[ $key == $'\e' ]]; then
            clear
            echo "Opening Main Menu..."
            exec $0

        fi
    done
}

# Show the dialog to choose an option
choice=$(zenity --list --title="HotspotShield VPN" --text="Select an option:" --radiolist --column="" --column="Option" TRUE "Default Location" FALSE "More Locations" FALSE "Status" FALSE "Disconnect" --height 200)
default_location="frpar"
selected_item=""
selected_location=""
if [[ $choice == "Default Location" ]]; then
    # Assign "frpar" as the selected item
    selected_item=$default_location

elif [[ $choice == "More Locations" ]]; then

    # Run the command and store the output in an array
    options=()
    while read -r option_name option_label; do
        options+=("$option_name   <<-->>   $option_label")
    done < <(hotspotshield locations | awk 'NR>2 {print $1, $2, $3, $4}')

    # Show the Zenity list dialog with the menu options
    selected_items=$(zenity --list --title="HotspotShield VPN" --text="Select a location:" --radiolist --column="" --column="Options" "${options[@]}" --height 360 --width 400 --multiple)
    if [[ -n "$selected_items" ]]; then
        selected_item=$selected_items
    else
        echo "No location selected. Exiting..."
        exit 0
    fi
elif [[ $choice == "Status" ]]; then
    # Run hotspotshield status
    hss_status
elif [[ $choice == "Disconnect" ]]; then
    # Run hotspotshield status
    hotspotshield disconnect
fi

if [[ -n "$selected_item" ]]; then
    # Call the connection function with the selected item
    hss_connect "$selected_item"
fi
