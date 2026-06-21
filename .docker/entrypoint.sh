#!/bin/bash

set -e
shopt -s nullglob

set -a
source .env
set +a

if [ -z "$DIR_NAME" ]; then
  echo "Error: DIR_NAME is not set. Please set DIR_NAME in the .env file." >&2
  exit 1
fi

RAW_DIR="./output/raw/$DIR_NAME"
MP4_DIR="./output/mp4/$DIR_NAME"

mkdir -p "$RAW_DIR" "$MP4_DIR"

has_input=false
if [ -d ./input/VIDEO_TS ]; then
  mv ./input/VIDEO_TS "$RAW_DIR"
  has_input=true
fi

if [ -d ./input/DVD_RTAV ]; then
  mv ./input/DVD_RTAV "$RAW_DIR"
  has_input=true
fi

if [ "$has_input" = false ]; then
  echo "Error: input/VIDEO_TS or input/DVD_RTAV was not found." >&2
  exit 1
fi

convert_to_mp4() {
  local input_file="$1"
  local output_file="$2"

  ffmpeg -i "$input_file" -map 0:v:0 -map 0:a:0? -c:v libx264 -preset slow -crf 23 \
         -c:a aac -b:a 192k -movflags +faststart \
         "$output_file"
}

i=1
for file in "$RAW_DIR/VIDEO_TS/"*.[Vv][Oo][Bb]; do
  case "$(basename "$file")" in
    [Vv][Ii][Dd][Ee][Oo]_[Tt][Ss].[Vv][Oo][Bb])
      continue
      ;;
  esac

  convert_to_mp4 "$file" "$MP4_DIR/part${i}.mp4"
  i=$((i+1))
done

for file in "$RAW_DIR/DVD_RTAV/"*.[Vv][Rr][Oo]; do
  convert_to_mp4 "$file" "$MP4_DIR/part${i}.mp4"
  i=$((i+1))
done

if [ "$i" -eq 1 ]; then
  echo "Error: no VOB or VRO video files were found." >&2
  exit 1
fi

echo 'DIR_NAME=""' > .env
