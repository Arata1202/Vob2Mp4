#!/bin/bash

set -e

mv ./input/VIDEO_TS ./output/raw/

i=1
for file in ./output/raw/VIDEO_TS/*.[Vv][Oo][Bb]; do
  ffmpeg -i "$file" -map 0:v:0 -map 0:a:0 -c:v libx264 -preset slow -crf 23 \
         -c:a aac -b:a 192k -movflags +faststart \
         "./output/mp4/part${i}.mp4"
  i=$((i+1))
done
