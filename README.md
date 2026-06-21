## Getting Started

### How to Run

```bash
# Move VIDEO_TS folder from DVD rip or extraction into the input directory
mv VIDEO_TS input/

# Prepare and edit .env file
cp .env.example .env
vi .env

# Run the conversion process
make run
```

### DVD-VR / VRO Input

DVD-RW discs recorded in DVD-VR mode may contain a `DVD_RTAV` folder instead of
`VIDEO_TS`. In that case, move the `DVD_RTAV` folder into the input directory.
The converter will process `.VRO` files such as `VR_MOVIE.VRO`.

```bash
# Move DVD_RTAV folder from DVD-VR disc into the input directory
mv DVD_RTAV input/

# Prepare and edit .env file
cp .env.example .env
vi .env

# Run the conversion process
make run
```

Supported input layouts:

```text
input/VIDEO_TS/*.VOB
input/DVD_RTAV/*.VRO
```
