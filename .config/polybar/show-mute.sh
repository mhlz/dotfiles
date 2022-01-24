#!/bin/bash

pactl subscribe | grep --line-buffered "source" | while read -r UNUSED_LINE; do pactl get-source-mute @DEFAULT_SOURCE@ 2>/dev/null | grep "Mute"; done
