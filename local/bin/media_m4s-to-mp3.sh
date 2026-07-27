#!/bin/bash

#!/bin/bash

# Script to convert m4s files to mp3 using ffmpeg and remove original files

# Set the target directory
# DOWNLOAD_DIR="${HOME}/Downloads"
DOWNLOAD_DIR="/run/media/eason/Bike-chan/Library/media/Music/"

# Check if the downloads directory exists
if [ ! -d "${DOWNLOAD_DIR}" ]; then
    echo "Error: Directory ${DOWNLOAD_DIR} does not exist"
    exit 1
fi

# Check if ffmpeg is installed
if ! command -v ffmpeg &> /dev/null; then
    echo "Error: \033[31mffmpeg\033[0m is not installed or not in PATH"
    exit 1
fi

# Find all m4s files and process them
find "${DOWNLOAD_DIR}" -type f -name "*.m4s" -print0 | while IFS= read -r -d '' m4s_file; do
    # Generate output filename by replacing .m4s with .mp3
    mp3_file="${m4s_file%.m4s}.mp3"
    
    echo "Processing: ${m4s_file}"
    
    # Convert m4s to mp3 using copy codec (stream copy)
    if ffmpeg -i "${m4s_file}" -c copy -y "${mp3_file}" 2>/dev/null; then
        echo "Successfully converted: ${mp3_file}"
        
        # Remove the original m4s file
        if rm -f "${m4s_file}"; then
            echo "Removed original file: ${m4s_file}"
        else
            echo "Warning: Failed to remove ${m4s_file}"
        fi
    else
        echo "Error: Failed to convert ${m4s_file}"
        
        # Clean up partial mp3 file if conversion failed
        if [ -f "${mp3_file}" ]; then
            rm -f "${mp3_file}"
            echo "Removed incomplete output file: ${mp3_file}"
        fi
    fi
    
    echo "-----------------------------------"
done

echo "All conversions completed"

