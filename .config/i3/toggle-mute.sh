#!/bin/bash

for i in $(pactl list short sources | awk '{print $1}'); do
    pactl set-source-mute $i toggle
done

