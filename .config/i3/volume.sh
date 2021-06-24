#!/bin/bash

# Configuration
STEP="5"    # Anything you like.
UNIT="%"   # dB, %, etc.

# Set volume
SETVOL="pactl set-sink-mute @DEFAULT_SINK@"

case "$1" in
    "up")
          $SETVOL +$STEP$UNIT
          ;;
  "down")
          $SETVOL -$STEP$UNIT
          ;;
  "mute")
          $SETVOL toggle
          ;;
esac

# Get current volume and state
VOLUME=$(amixer get Master | grep 'Mono:' | cut -d ' ' -f 6 | sed -e 's/[^0-9]//g')
STATE=$(amixer get Master | grep 'Mono:' | grep -o "\[off\]")

# Show volume with volnoti
if [[ -n $STATE ]]; then
  volnoti-show -m
else
  volnoti-show $VOLUME
fi

exit 0
