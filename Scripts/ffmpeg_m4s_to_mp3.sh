#!/bin/bash

# m4s_to_mp3.sh - Convert .m4s files to .mp3 using ffmpeg

set -uo pipefail

# ------------------------------------------------------------
# usage: display help message (no emoji)
# ------------------------------------------------------------
usage() {
    cat <<EOF
Convert .m4s files to .mp3 using ffmpeg (audio only, libmp3lame, VBR quality 2).

Usage:
    $0 [--dry-run] [--delete]
    $0 -d, --directly <directory> [--dry-run] [--delete]
    $0 -r, --recursive <directory> [--dry-run] [--delete]
    $0 -h, --help

Mode options (mutually exclusive – choose exactly one; all require a directory argument after the flag):
    (no mode flag)        Process all *.m4s files in the current directory.
    -d, --directly DIR    Process all *.m4s files in DIR (non‑recursive, only the top level).
    -r, --recursive DIR   Process all *.m4s files in DIR recursively.

Additional options:
    --dry-run             Print the ffmpeg commands that would be run, without actually converting.
    --delete              Delete the original .m4s file after a successful conversion.
    -h, --help            Show this help message and exit.

Notes:
    - Options --dry-run and --delete may be combined with any mode option.
    - The -r and -d flags MUST be followed immediately by the target directory path.
      For example:  $0 -r /path/to/music   (correct)
                    $0 -r -d /path         (WRONG – "-d" would be taken as the directory for -r)
    - The script verifies that the given directory exists before proceeding.

Examples:
    $0                              Process all .m4s files in the current directory.
    $0 -d /home/user/videos        Convert files in /home/user/videos (non‑recursive).
    $0 -r ./media --delete          Recursively convert all .m4s under ./media and delete originals.
    $0 -r /music --dry-run         Show what would be done under /music (no changes made).
EOF
}

# ------------------------------------------------------------
# Parse command line arguments
# ------------------------------------------------------------
TEMP=$(getopt -o d:r:h \
       -l directly:,recursive:,help,dry-run,delete \
       -n "$0" -- "$@")

if [ $? -ne 0 ]; then
    echo "Error: Invalid option. Use -h for help." >&2
    exit 1
fi

eval set -- "$TEMP"

# Default values
directory=""
recursive=false
dry_run=false
delete_after=false
dir_mode=false
recursive_mode=false

while true; do
    case "$1" in
        -d|--directly)
            directory="$2"
            dir_mode=true
            shift 2
            ;;
        -r|--recursive)
            directory="$2"
            recursive_mode=true
            shift 2
            ;;
        -h|--help)
            usage
            exit 0
            ;;
        --dry-run)
            dry_run=true
            shift
            ;;
        --delete)
            delete_after=true
            shift
            ;;
        --)
            shift
            break
            ;;
        *)
            echo "Internal error!" >&2
            exit 1
            ;;
    esac
done

# Check conflicting modes
if $dir_mode && $recursive_mode; then
    echo "Error: -d/--directly and -r/--recursive cannot be used together." >&2
    exit 1
fi

# Set target directory if not given (no options mode)
if ! $dir_mode && ! $recursive_mode; then
    directory="."
fi

# ------------------------------------------------------------
# Verify target directory exists
# ------------------------------------------------------------
if [ ! -d "$directory" ]; then
    echo "Error: Directory '$directory' does not exist." >&2
    exit 1
fi

# ------------------------------------------------------------
# Collect .m4s files
# ------------------------------------------------------------
if $recursive_mode; then
    # recursive search
    mapfile -d '' m4s_files < <(find "$directory" -type f -name '*.m4s' -print0)
else
    # non-recursive, only top level
    mapfile -d '' m4s_files < <(find "$directory" -maxdepth 1 -type f -name '*.m4s' -print0)
fi

if [ ${#m4s_files[@]} -eq 0 ]; then
    echo "No .m4s files found in '$directory'."
    exit 0
fi

# ------------------------------------------------------------
# Process each file
# ------------------------------------------------------------
for m4s_file in "${m4s_files[@]}"; do
    # Check if file contains audio stream using ffprobe
    if ! ffprobe -v error -select_streams a -show_entries stream=codec_type -of csv=p=0 "$m4s_file" | grep -q audio; then
        echo "Skipping '$m4s_file': no audio stream found."
        continue
    fi

    # Output filename
    mp3_output="${m4s_file%.m4s}.mp3"

    # Dry-run: just show command
    if $dry_run; then
        echo "Would run: ffmpeg -i \"$m4s_file\" -vn -c:a libmp3lame -q:a 2 \"$mp3_output\" -y"
        if $delete_after; then
            echo "Would delete: \"$m4s_file\""
        fi
        continue
    fi

    # Perform conversion (suppress normal ffmpeg output, keep errors)
    echo "Converting: $m4s_file"
    if ffmpeg -v error -i "$m4s_file" -vn -c:a libmp3lame -q:a 2 "$mp3_output" -y; then
        echo "Success: $mp3_output"
        if $delete_after; then
            rm "$m4s_file" && echo "Deleted: $m4s_file"
        fi
    else
        echo "Error: Conversion failed for '$m4s_file'." >&2
    fi
done

