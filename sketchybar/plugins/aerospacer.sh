#!/bin/bash

source "$HOME/.config/sketchybar/colors.sh"

# Get list of non-empty workspaces
nonempty_workspaces=($(aerospace list-workspaces --monitor all --empty no))
# Get the focused workspace
focused_workspaces=($(aerospace list-workspaces --focused))

# Concatenate arrays
used_workspaces=("${nonempty_workspaces[@]}" "${focused_workspaces[@]}")
# Remove duplicates using an associative array
unique_concatenated_array=()
for item in "${used_workspaces[@]}"; do
    # Check if the item is already in the unique_concatenated_array
    if [[ ! " ${unique_concatenated_array[@]} " =~ " ${item} " ]]; then
        unique_concatenated_array+=("$item")
    fi
done
# Sort the unique array
used_workspaces=($(printf "%s\n" "${unique_concatenated_array[@]}" | sort))

# Get list of monitors)
monitors=()
while IFS= read -r line; do
    monitors+=("${line:0:1}")
done < <(aerospace list-monitors)

# Create an array that specifies the monitor for each workspace
for monitor_id in "${monitors[@]}"; do
    workspaces_on_monitor=($(aerospace list-workspaces --monitor $monitor_id))
    for workspace in "${workspaces_on_monitor[@]}"; do
        monitor_of_workspace["$workspace"]=$monitor_id
    done
done

if [ "$SENDER" = "aerospace_workspace_change" ]; then
    for element in $(aerospace list-workspaces --all); do
        if [ "$element" = "${focused_workspaces[0]}" ]; then
            sketchybar --set space.$element background.color=$ACCENT_COLOR \
                                            icon.color=$SHADOW_COLOR \
                                            label.color=$SHADOW_COLOR \
                                            display=${monitor_of_workspace["$element"]} \
                                            background.drawing=on \
                                            icon.drawing=on \
                                            label.drawing=on \
                                            label.padding_right=20
        else
            sketchybar --set space.$element background.color=$ITEM_BG_COLOR \
                                            icon.color=$MAIN_COLOR \
                                            label.color=$MAIN_COLOR \
                                            display=${monitor_of_workspace["$element"]}
        fi
    done
    exit 0
fi

# Loop through all workspaces to hide the ones that are not in used_workspaces
for sid in $(aerospace list-workspaces --all); do
    # Check if the sid is not in used_workspaces
    if [[ ! " ${used_workspaces[@]} " =~ " $sid " ]]; then
        sketchybar --set space.$sid background.drawing=off \
                                    icon.drawing=off \
                                    label="" \
                                    label.padding_right=0 \
                                    background.padding_left=0 \
                                    background.padding_right=0                             
                                      
    fi
done

for element in "${used_workspaces[@]}"; do

    app_list=()
    while IFS= read -r line; do
        app_list+=("$line")
    done < <(aerospace list-windows --workspace "$element" | awk -F '|' '{print $2}' | sed 's/^ *//;s/ *$//')

    icon_strip=" —" # Default value for empty app list
    if [ "${app_list[*]}" != "" ]; then # Check if array is non-empty
        icon_strip="" # Reset for app list processing
        for app in "${app_list[@]}"; do
            icon_strip+=" $($CONFIG_DIR/plugins/icon_map_fn.sh "$app")"
        done
    fi

    sketchybar --set space.$element label="$icon_strip"                                        \
                                    label.padding_right=10                                     \
                                    label.drawing=on                                           \
                                    background.padding_left=3                                  \
                                    background.padding_right=3                                 \
                                    background.drawing=on                                      \
                                    icon.drawing=on                                            \
                                    display=${monitor_of_workspace["$element"]}

done