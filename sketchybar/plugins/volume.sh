#!/bin/sh

# The volume_change event supplies a $INFO variable in which the current volume
# percentage is passed to the script.

audio_device=($(system_profiler SPAudioDataType | awk '/Default Output Device: Yes/{print device}; {if ($0 ~ /:/) device=$1}'))

# check if audio device is "Altoparlanti" then set volume icon
if [ "${audio_device}" = "Altoparlanti" ]; then

  if [ "$SENDER" = "volume_change" ]; then
    VOLUME="$INFO"

    case "$VOLUME" in
      [6-9][0-9]|100) ICON="􀊨"
      ;;
      [3-5][0-9]) ICON="􀊦"
      ;;
      [1-9]|[1-2][0-9]) ICON="􀊤"
      ;;
      *) ICON="􀊢"
    esac

    sketchybar --set "$NAME" icon="$ICON" label="$VOLUME%"
  fi

elif [ "${audio_device}" = "WH-1000XM3:" ]; then
  sketchybar --set "$NAME" icon="􀺹" label="$INFO%"

# else if the name is "M-Track" set another fixed icon
elif [ "${audio_device}" = "M-Track" ]; then
  sketchybar --set "$NAME" icon="􀝎" label="M-Track 2x2"
fi