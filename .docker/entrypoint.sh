#!/bin/bash

set -e

set -a
source .env
set +a

mv ./input/VIDEO_TS "${RAW_OUTPUT_PATH}/"

i=1
for file in "${RAW_OUTPUT_PATH}/VIDEO_TS"/*.[Vv][Oo][Bb]; do
  ffmpeg -i "$file" -map 0:v:0 -map 0:a:0 -c:v libx264 -preset slow -crf 23 \
         -c:a aac -b:a 192k -movflags +faststart \
         "${MP4_OUTPUT_PATH}/part${i}.mp4"
  i=$((i+1))
done
