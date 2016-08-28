#!/bin/bash

INPUT="$1"
OUTPUT="${1%.mkv}.mp4"

if [ "$2" != "" ]; then
	OUTPUT="$2"
fi

START=$(date +%s)

ffmpeg -hide_banner -loglevel panic -i "$INPUT" -metadata title="" -c:v copy -c:a libfdk_aac -ac 2 -movflags +faststart "$OUTPUT"

END=$(date +%s)
FILENAME=$(basename "$INPUT")

echo "File ($FILENAME) took $((END - START)) second(s) to convert."