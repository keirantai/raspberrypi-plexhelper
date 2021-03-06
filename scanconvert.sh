#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
SRCDIR=$1

if [ "$SRCDIR" == "" ]; then
	echo "Usage:";
	echo "  $0 <path_to_scan>";
	exit 1;
fi

find "$SRCDIR" -name "*.mkv" -o -name "*.avi" -type f | 
while read filename
do
	file=$(basename "$filename")
	fname="${file%.*}"
	ext="${file##*.}"

	# find next file if MP4 file exists
	if [ -f "${fname}.mp4" ]; then
		echo "Skipped. MP4 file already exists:"
		echo "${fname}.mp4"
		echo "keep scanning..."
		echo ""
		continue
	fi

	case "$ext" in
		avi)
			$DIR/avi2mp4.sh $file
			;;
		mkv)
			$DIR/mkv2mp4.sh $file
			;;
		*)
			echo "Unknown file extension: $ext"
			;;
	esac
done