#!/bin/bash

if command -v xclip &>/dev/null; then
	date "+%H:%M %m.%d" | tr -d '\n' | xclip -sel c
else
	echo -e "$0\t==>\t\033[31mxclip\033[0m not found!"
fi

