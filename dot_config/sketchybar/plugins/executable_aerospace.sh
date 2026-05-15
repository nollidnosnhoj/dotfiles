#!/usr/bin/env bash

# make sure it's executable with:
# chmod +x ~/.config/sketchybar/plugins/aerospace.sh

sid="$1"
apps=$(aerospace list-windows --workspace "$sid" | awk -F'|' '{gsub(/^ *| *$/, "", $2); print $2}')

if [ -n "$apps" ]; then
  icon_strip=" "
  while read -r app; do
    icon_strip+=" $($CONFIG_DIR/plugins/icon_map_fn.sh "$app")"
  done <<<"${apps}"
else
  icon_strip=""
fi

if [ "$sid" = "$FOCUSED_WORKSPACE" ]; then
  sketchybar --set "$NAME" \
    label="$icon_strip" \
    background.color=0xff003547 \
    label.shadow.drawing=on \
    icon.shadow.drawing=on \
    background.border_width=2
else
  sketchybar --set "$NAME" \
    label="$icon_strip" \
    background.color=0x44FFFFFF \
    label.shadow.drawing=off \
    icon.shadow.drawing=off \
    background.border_width=0
fi
