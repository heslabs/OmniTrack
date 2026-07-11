# Quick Start Guide


---
## On-Device Object Tracking Pipeline
This system operates as a zero-shot, template-matching visual tracker running locally on your device.

#### Core Mechanics
* **Zero-Shot Initialization**: The system does not require pre-training on specific objects or coordinate inputs.
* **Dynamic Template Matching**: Pressing start captures the pixel data within the reticle to create a reference visual template.
* **Real-Time Processing**: The device benchmarks at ~30 frames per second (FPS), executing search algorithms over subsequent frames to update the object's position.
* **Instant Reset**: Interrupting the loop allows the user to redefine the visual template instantly by re-framing the target

#### Step-by-Step Workflow

```
[ Aim Target ] ---> [ Press Start ] ---> [ Lock Pixels ] ---> [ Loop: Track @ 30 FPS ]
       ^                                                                     |
       |_______________________ (Re-aim Anytime) ____________________________| 
```

* **Aim**: Frame the target in the on-screen reticle without clicking.
* **Lock**: Press start to grab the pixels in the reticle.
* **Follow**: A live box tracks the target approximately 30 times per second. 


---
## Operation Modes
 
Configure your pipeline by defining inputs, behavior, and outputs in **config/runtime.toml**. Update these parameters and restart the service to apply changes. Below is a structured implementation of your operational modes for the runtime configuration file.

```
## ~/sandbox/omnitrack_server/config/runtime.toml
# ==========================================
# RUNTIME CONFIGURATION
# ==========================================
## Input
[capture]
* MIPI CSI Camera
* RTSP
* Mp4
* Image Sequence
 
## Behavior
[fsm]
How the tracker behaves:
* init mode (reticle vs explicit)
* loss heuristic thresholds
* sticky tracking (auto-reinit)
* color overlay
[tracker]
Which compiled model to load and its geometry.

## Output
[network] bbox UDP destination + init port
[display] HDMI preview on/off
[recording] evidence mp4 + bbox CSV sidecar
[streaming] RTP H.264 to a LAN peer
[logging] persistent trace CSV
```

---
#### Data Flow
Pixels enter at the left, the FSM decides what to do, four output channels carry the result.
* Three output channels are opt-in: recording, streaming, and (effectively) HDMI display
  * set sink_pipeline = "" to disable
* The bbox UDP feed is always on — it doubles as a liveness signal: idle and tracking states both emit datagrams.

```
[ Capture ] ---> [ Tracker ] ---> [ FSM ] +---> [display] HDMI preview
                                          |
                                          +---> [network] UDP:5004 bbox JSON
                                          |
                                          +---> [recording] evidence mp4 + bbox.csv
                                          |
                                          +---> [streaming] RTP H.264 to peer 
```


---
### Start RTSP video stream

```
## mediamtx on :8554, then publish:
ffmpeg -re -stream_loop -1 -i video.mp4 -c:v copy -an -f rtsp \
rtsp://127.0.0.1:8554/drone18
```

---
### View RTSP video stream 
```
vlc rtsp://127.0.0.1:8554/drone18
vlc rtsp://192.168.52.83:8554/drone18
ffplay -rtsp_transport tcp "rtsp://192.168.52.83:8554/drone18"
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
### Start MediaMTX

To start MediaMTX, run the standalone binary executable file or launch its official container, depending on your system setup.
* Execution Methods: Using Standalone Binary: Navigate to the directory where you extracted the MediaMTX files and execute the command corresponding to your operating system:

```
git clone https://github.com/eyepop-ai/eyepop-mediamtx
```

**Installation**

There are several installation methods available: standalone binary, Docker image, Arch Linux package and OpenWrt binary.

**Standalone binary**

Download and extract a standalone binary from the release page that corresponds to your operating system and architecture.

* release page: https://github.com/bluenviron/mediamtx/releases
* mediamtx_v1.19.2_linux_amd64.tar.gz (25.4MB)

```
wget https://github.com/bluenviron/mediamtx/releases/download/v1.19.2/mediamtx_v1.19.2_linux_amd64.tar.gz
```


**Start the server:**
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



