#!/bin/bash

if [ $SENDER = "aerospace_mode_change" ]; then
   if [ $ACTIVE_MODE = "main" ]; then
      sketchybar --set aerospace_mode label.drawing=off
   elif [ $ACTIVE_MODE = "service" ]; then
      sketchybar --set aerospace_mode label.drawing=on \
                                      label="Service Mode"
   elif [ $ACTIVE_MODE = "resize" ]; then
      sketchybar --set aerospace_mode label.drawing=on \
                                      label="Resize Mode"
   fi
fi 