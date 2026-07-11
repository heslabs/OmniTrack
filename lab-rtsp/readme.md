## Tracking object from RTSP video source

---
### Setp 1: Start RTSP video server

```
## mediamtx on :8554, then publish:
ffmpeg -re -stream_loop -1 -i video.mp4 -c:v copy -an -f rtsp \
rtsp://127.0.0.1:8554/drone18
```

* video.mp4 [[Drive]](https://drive.google.com/file/d/1JByr_Y-hDMpfA7WIG9jJH_s_0etgXqgb/view?usp=sharing)

---
### Step 2: View RTSP video stream 

```
vlc rtsp://127.0.0.1:8554/drone18
vlc rtsp://192.168.52.83:8554/drone18
ffplay -rtsp_transport tcp "rtsp://192.168.52.83:8554/drone"
```

**run-ffplay.sh**
```
#!/bin/bash -f
if [ $# -eq 0 ]; then
    echo "$0 192.168.52.81"
    exit 1
fi
ffplay -rtsp_transport tcp "rtsp://$1:8554/drone18"
```

---
### Step 3: Start On-device tracking

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

cd /home/deepmentor/sandbox/omnitrack_client
# by pass top-left x y w h not cx cy
python send_init.py 127.0.0.1 5005 546 463 79 53
wait "$TRACKER_PID"
```


---
## Prerequisites

---
### Install and Start MediaMTX

To start MediaMTX, run the standalone binary executable file or launch its official container, depending on your system setup.

#### Clone the Github
```
git clone https://github.com/eyepop-ai/eyepop-mediamtx
```

#### Installation
There are several installation methods available: standalone binary, Docker image, Arch Linux package and OpenWrt binary.

#### Standalone binary
Download and extract a standalone binary from the release page that corresponds to your operating system and architecture.

* release page: https://github.com/bluenviron/mediamtx/releases
* mediamtx_v1.19.2_linux_amd64.tar.gz (25.4MB)

```
wget https://github.com/bluenviron/mediamtx/releases/download/v1.19.2/mediamtx_v1.19.2_linux_amd64.tar.gz
```

Start the server:
```
./mediamtx
```

Log message
```
2026/07/10 15:09:10 INF MediaMTX v1.19.2, linux, amd64
2026/07/10 15:09:10 INF configuration loaded from /home/demo/labs/qcom6a/mediamtx/mediamtx.yml
2026/07/10 15:09:10 INF [RTSP] started with listeners on :8554 (TCP/RTSP), :8000 (UDP/RTP), :8001 (UDP/RTCP)
2026/07/10 15:09:10 INF [RTMP] started with listener on :1935 (TCP/RTMP)
2026/07/10 15:09:10 INF [HLS] started with listener on :8888 (TCP/HTTP)
2026/07/10 15:09:10 INF [WebRTC] started with listeners on :8889 (TCP/HTTP), :8189 (UDP/ICE)
2026/07/10 15:09:10 INF [SRT] started with listener on :8890 (UDP/SRT)
2026/07/10 15:09:10 INF [MoQ] started with listeners on :8892 (TCP/HTTP2), :8892 (UDP/HTTP3)
```
