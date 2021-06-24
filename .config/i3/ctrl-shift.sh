#!/bin/bash

if xprop -id $(xdotool getwindowfocus) | grep "kitty" | grep WM_CLASS > /dev/null; then 
    xdotool key --clearmodifiers ctrl+shift+$1;
else
    xdotool key --clearmodifiers ctrl+$1;
fi

