#!/bin/bash
#
# A context-aware script to control the brightness of the currently focused monitor.
# It determines whether the focused monitor is internal or external and uses the
# appropriate tool (brightnessctl or ddcutil).
#

# --- User Configuration ---
# This is where you map your monitor names to the correct control method.
#
# 1. Get monitor names from: `hyprctl monitors`
# 2. Get ddcutil display numbers from: `ddcutil detect`
#
# -----------------------------------------------------------------------------

# An associative map of [HYPRLAND_MONITOR_NAME]="DDCUTIL_DISPLAY_NUMBER"
declare -A EXTERNAL_MONITORS
EXTERNAL_MONITORS=(
    ["HDMI-A-1"]=1
    # Add your own external monitors here, e.g., ["DP-2"]=3
)

# A simple array of internal monitor names.
INTERNAL_MONITORS=(
    "eDP-2"
    # Add other potential internal names if needed
)

# --- Script Logic (No need to edit below this line) ---

# Input validation
if [ -z "$1" ]; then
    echo "Usage: $(basename "$0") [+|-]<value> | <absolute_value>"
    exit 1
fi
if ! [[ "$1" =~ ^([+-])?([0-9]+)$ ]]; then
    echo "Error: Invalid argument '$1'." >&2
    exit 1
fi

# Get the name of the currently focused monitor from Hyprland
FOCUSED_MONITOR=$(hyprctl monitors -j | jq -r '.[] | select(.focused == true).name')

if [ -z "$FOCUSED_MONITOR" ]; then
    echo "Error: Could not determine the focused monitor." >&2
    exit 1
fi

# Check if the focused monitor is in our INTERNAL_MONITORS list
IS_INTERNAL=false
for item in "${INTERNAL_MONITORS[@]}"; do
    if [ "$item" == "$FOCUSED_MONITOR" ]; then
        IS_INTERNAL=true
        break
    fi
done

# Check if the focused monitor is in our EXTERNAL_MONITORS list
IS_EXTERNAL=false
DDC_DISPLAY=""
if [[ -v EXTERNAL_MONITORS[$FOCUSED_MONITOR] ]]; then
    IS_EXTERNAL=true
    DDC_DISPLAY=${EXTERNAL_MONITORS[$FOCUSED_MONITOR]}
fi


# --- Execute Brightness Change ---

if $IS_INTERNAL; then
    echo "Controlling internal display ($FOCUSED_MONITOR) with brightnessctl..."
    if [[ "$1" =~ ^[0-9]+$ ]]; then
        brightnessctl set "${1}%"
    else
        brightnessctl set "${1:1}%${1:0:1}"
    fi
elif $IS_EXTERNAL; then
    echo "Controlling external display ($FOCUSED_MONITOR) with ddcutil (Display $DDC_DISPLAY)..."
    if [[ "$1" =~ ^[0-9]+$ ]]; then
        ddcutil --display "$DDC_DISPLAY" setvcp 10 "$1"
    else
        ddcutil --display "$DDC_DISPLAY" setvcp 10 "${1:0:1}" "${1:1}"
    fi
else
    echo "Error: Monitor '$FOCUSED_MONITOR' is not configured in the script." >&2
    exit 1
fi
