#!/bin/bash
declare -a opts=(
  "Active Window"
  "Select window"
  "All Monitors"
)
time=$(date +%Y-%m-%d_%H-%M-%S) 


choice=$(printf '%s\n' "${opts[@]}" | rofi -dmenu)
case "$choice" in
  "Active Window")
    name=$(echo "$(xprop -id "$(xdotool getwindowfocus)" WM_CLASS | awk -F'["]' '{print $2}')"_"$(date +%Y-%m-%d_%H-%M-%S)") 
    scrot -u -d 1 ~/Pictures/$name.png
    sleep 1
    notify-send "Scrot" "Taken screenshot of active window and saved to ~/Pictures (copied to clipboard)" -i ~/Pictures/$name.png -t 2000
    xclip -selection clipboard -t image/png < ~/Pictures/$name.png
    ;;
  "Select window")
    name=$(echo "$(xprop -id "$(xdotool getactivewindow)" WM_CLASS | awk -F'["]' '{print $2}')"_"$(date +%Y-%m-%d_%H-%M-%S)")
    scrot -s -d 1 ~/Pictures/$name.png
    sleep 1
    notify-send "Scrot" "Taken screenshot of selected window and saved to ~/Pictures" -i ~/Pictures/$name.png -t 2000
    ;;
  "All Monitors")
    scrot -d 1 ~/Pictures/%Y-%m-%d_%H-%M-%S.png
    sleep 1
    notify-send "Scrot" "Taken screenshot of all monitors and saved to ~/Pictures" -t 2000
    ;;
esac
