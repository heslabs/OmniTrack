## Tracking object from JPEG images source

---
### Setp 1: Prepare JPEG images soruce

```
### JPEG images source
~/sandbox/data/img/*.jpg
```
 
---
### Step 2: Modify the configuration file

```
cd ~/sandbox/omnitrack_server
vim config/runtime.toml
```

**runtime.toml**
```
[capture]
# LaSOT drone-5 sequence (3332 frames @ /home/deepmentor/sandbox/data/img/)
pipeline = "multifilesrc location=/home/deepmentor/sandbox/data/img/%08d.jpg start-index=1 loop=true caps=image/jpeg,framerate=30/1 ! jpegdec ! videoconvert ! videorate ! video/x-raw,format=NV12,width=1280,height=720,framerate=30/1 ! identity sync=true ! appsink name=sink emit-signals=true drop=1 max-buffers=1 sync=false"
[recording]
enable = true
encoder = "sw_h264"
output_dir = "/home/deepmentor/sandbox/recordings"
file_pattern = "evidence_%05d.mp4"
```


---
### Step 3: Start on-device tracking

```
cd ~/sandbox/omnitrack_server
sudo ./start.sh
```

**start.sh**
```
#!/usr/bin/env bash
cp -f runtime-rtsp.toml ./config/runtime.toml

HERE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
export QNN_SDK_ROOT="${QNN_SDK_ROOT:-${HERE}}"
export QNN_LIB_DIR="${QNN_LIB_DIR:-${HERE}/lib/aarch64-ubuntu-gcc9.4}"
export LD_LIBRARY_PATH="${QNN_LIB_DIR}:${LD_LIBRARY_PATH:-}"
export ADSP_LIBRARY_PATH="${QNN_LIB_DIR}:/dsp"
export DSP_LIBRARY_PATH="${QNN_LIB_DIR}"

LOG="${HERE}/demo.log"
# Truncate the log so we never match a "threads up" line from a previous run.
: > "$LOG"

"${HERE}/omnitrack_runtime" --config "${HERE}/config/runtime.toml" "$@" >> "$LOG" 2>&1 &
TRACKER_PID=$!

# Poll the log until the runtime signals all threads are up and the UDP
# init listener is bound — then immediately send the init bbox.
until grep -q "\[runtime\] all threads up" "$LOG" 2>/dev/null; do
    sleep 0
done

cd ~/sandbox/omnitrack_client
# by pass top-left x y w h not cx cy
python send_init.py 127.0.0.1 5005 546 463 79 53
wait "$TRACKER_PID"
```
