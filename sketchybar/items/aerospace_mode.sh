#!/usr/bin/env sh

sketchybar --add event aerospace_mode_change

sketchybar --add item aerospace_mode center \
           --subscribe aerospace_mode aerospace_mode_change \
           --set aerospace_mode background.drawing=off \
                                label.drawing=off \
                                label.color=$RED \
                                script=$PLUGIN_DIR/aerospace_mode.sh
