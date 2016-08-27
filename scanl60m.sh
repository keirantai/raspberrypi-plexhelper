#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
SRCDIR=$1

if [ "$SRCDIR" == "" ]; then
	echo "Usage:";
	echo "  $0 <path_to_scan>";
	exit 1;
fi

find "$SRCDIR" -name "*.mkv" -o -name "*.avi" -type f -mmin -60 | 
while read filename
do
	file=$(basename "$filename")
	fname="${file%.*}"
	ext="${file##*.}"

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