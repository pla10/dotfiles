#!/bin/bash

app_list=()
while IFS= read -r line; do
   echo "$line"
   app_list+=("$line")
done < <(aerospace list-windows --workspace 2 | awk -F '|' '{print $2}' | sed 's/^ *//;s/ *$//')

echo "----"
echo "${app_list[*]}"
echo "----"
echo "${app_list[@]}"
echo "----"


icon_strip=" —" # Default value for empty app list
if [ "${app_list[*]}" != "" ]; then # Check if array is non-empty
   icon_strip="" # Reset for app list processing
   for app in "${app_list[@]}"; do
      echo "$app"
      icon_strip+=" $(/Users/placido/.config/sketchybar/plugins/icon_map_fn.sh "$app")"
   done
fi

echo "$icon_strip"