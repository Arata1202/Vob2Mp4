#!/bin/bash

set -e

set -a
source .env
set +a

RAW_DIR="./output/raw/$DIR_NAME"
MP4_DIR="./output/mp4/$DIR_NAME"

mkdir -p "$RAW_DIR" "$MP4_DIR"

mv ./input/VIDEO_TS "$RAW_DIR"

i=1
for file in "$RAW_DIR/VIDEO_TS/"*.[Vv][Oo][Bb]; do
  if [[ "$(basename "$file")" == "VIDEO_TS.VOB" ]]; then
    continue
  fi

  ffmpeg -i "$file" -map 0:v:0 -map 0:a:0? -c:v libx264 -preset slow -crf 23 \
         -c:a aac -b:a 192k -movflags +faststart \
         "$MP4_DIR/part${i}.mp4"
  i=$((i+1))
done
