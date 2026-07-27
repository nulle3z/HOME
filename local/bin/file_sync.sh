#!/bin/bash

if [ -f "./file_sync.py" ]; then
    python3 ./file_sync.py "$@"
else
    echo "ERROR: file_sync.py file not found in the current directory" >&2
    exit 1
fi

