#!/bin/bash

INPUT="$1"
OUTPUT="${1%.mkv}.mp4"

if [ "$2" != "" ]; then
	OUTPUT="$2"
fi

START=$(date +%s)

ffmpeg -hide_banner -loglevel panic -i "$INPUT" -metadata title="" \
#Generate a mssing PTS file from AVI.
-fflags +genpts \
#Stream mapping:
#Stream #0:0 -> #0:0 (copy)
#Stream #0:1 -> #0:1 (ac3 (native) -> aac (libfaac))
#Stream #0:1 -> #0:2 (copy)
-map 0:0 -map 0:1 -map 0:1 \
#Makes a global_header in the file if missing
-flags +global_header \
#copy the video mapped to 0:0
-c:v copy \
# Converts the audio maped to 0:1 to aac with a bitrate of 128k, AAC needs to be the first stream for plex to support direct play
-c:a:0 libfaac -b:a:1 128k \
#copys the audio mapped to 0:2
-c:a:1 copy \
# Enable faster start when steaming
-movflags +faststart \
# Uses the same name as input, minus the Suffix
"$OUTPUT"

END=$(date +%s)
FILENAME=$(basename "$INPUT")

echo "File ($FILENAME) took $((END - START)) second(s) to convert."