#!/bin/bash

# Directory where your wallpapers are stored
WALLPAPER_DIR="/home/dilux/Pictures/walls"

# Get a list of wallpaper files
wallpapers=$(ls "$WALLPAPER_DIR")

# Show the wallpaper selection menu in Rofi
selected_wallpaper=$(echo "$wallpapers" | rofi -dmenu -i -p "Select Wallpaper")

# If a wallpaper was selected, set it as the background for both light and dark styles
if [ -n "$selected_wallpaper" ]; then
    wallpaper_path="file://$WALLPAPER_DIR/$selected_wallpaper"

    # Apply wallpaper for the default (light) style
    gsettings set org.gnome.desktop.background picture-uri "$wallpaper_path"

    # Apply wallpaper for the dark style
    gsettings set org.gnome.desktop.background picture-uri-dark "$wallpaper_path" 2>/dev/null

    # Set the background style for light theme
    gsettings set org.gnome.desktop.background picture-options "zoom"

    # Check if "picture-options-dark" key exists and set the background style for dark theme if it does
    if gsettings list-keys org.gnome.desktop.background | grep -q "picture-options-dark"; then
        gsettings set org.gnome.desktop.background picture-options-dark "zoom"
    fi
else
    echo "No wallpaper selected."
fi
