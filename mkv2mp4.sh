#!/bin/bash

INPUT="$1"
OUTPUT="${1%.mkv}.mp4"

if [ "$2" != "" ]; then
	OUTPUT="$2"
fi

ffmpeg -hide_banner -loglevel panic -i "$INPUT" -metadata title="" -c:v copy -c:a libfdk_aac -ac 2 -movflags +faststart "$OUTPUT"