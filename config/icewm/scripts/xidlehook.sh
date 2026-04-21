#!/bin/sh

exec xidlehook \
  --not-when-fullscreen \
  --not-when-audio \
  --timer 150 \
  'brightnessctl -s set 100' \
  'brightnessctl -r' \
  --timer 20 \
  'xset dpms force off' \
  'xset dpms force on && brightnessctl -r' \
  --timer 120 \
  'xsecurelock' \
  'xset dpms force on && brightnessctl -r' \
  --timer 180 \
  'systemctl suspend' \
  'true'
