#!/usr/bin/env sh

POPUP_OFF="sketchybar --set apple.logo popup.drawing=off"
POPUP_CLICK_SCRIPT="sketchybar --set \$NAME popup.drawing=toggle"

sketchybar --add item           apple.logo left                             \
                                                                            \
           --set apple.logo     icon=􀣺                                      \
                                icon.font="SF Pro:Semibold:17.0"            \
                                background.padding_right=5                  \
                                background.color=$TRANSPARENT               \
                                label.drawing=off                           \
                                click_script="$POPUP_CLICK_SCRIPT"          \
                                                                            \
           --add item           apple.prefs popup.apple.logo                \
           --set apple.prefs    icon=􀍟                                      \
                                background.color=$POPUP_BACKGROUND_COLOR                     \
                                background.height=30                        \
                                label="Preferences"                         \
                                click_script="open -a 'System Preferences';
                                              $POPUP_OFF"                   \
                                                                            \
           --add item           apple.activity popup.apple.logo             \
           --set apple.activity icon=􀬏                                      \
                                background.color=$POPUP_BACKGROUND_COLOR                     \
                                background.height=30                        \
                                label="Activity"                            \
                                click_script="open -a 'Activity Monitor';
                                              $POPUP_OFF"\
                                                                            \
           --add item           apple.lock popup.apple.logo                 \
           --set apple.lock     icon=􀎠                                      \
                                background.color=$POPUP_BACKGROUND_COLOR                     \
                                background.height=30                        \
                                label="Lock Screen"                         \
                                click_script="osascript -e 'tell application \"System Events\" to keystroke \"q\" using {command down,control down}';
                                              $POPUP_OFF"