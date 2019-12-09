#!/bin/bash

id="$1"

app=$(yabai -m query --windows | jq -r "map(select(.pid==$id))[0].app")

if [[ $app == "Wow" ]]; then
	yabai -m config status_bar off
fi

