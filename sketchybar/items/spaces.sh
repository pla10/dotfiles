#!/usr/bin/env sh

sketchybar --add event aerospace_workspace_change

for sid in $(aerospace list-workspaces --all); do
    sketchybar --add item "space.$sid" left                                              \
               --set "space.$sid" icon="$sid"                                            \
                                  icon.color=$MAIN_COLOR                                 \
                                  icon.padding_left=10                                   \
                                  icon.padding_right=10                                  \
                                  label.font="sketchybar-app-font:Regular:16.0"          \
                                  label.padding_right=10                                 \
                                  label.padding_left=0                                   \
                                  background.padding_left=0                              \
                                  background.padding_right=0                             \
                                  background.drawing=off                                 \
                                  icon.drawing=off                                       \
                                  click_script="aerospace workspace $sid"                                    
done

sketchybar --add item space_separator left                                               \
           --subscribe space_separator aerospace_workspace_change                        \
           --set space_separator icon="􀆊"                                                \
                                 icon.color=$ACCENT_COLOR                                \
                                 icon.padding_left=4                                     \
                                 label.drawing=off                                       \
                                 background.drawing=off                                  \
                                 update_freq=2                                           \
                                 script=$PLUGIN_DIR/aerospacer.sh