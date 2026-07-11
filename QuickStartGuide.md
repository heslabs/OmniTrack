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
### System Architecture Overview
 
The system processes video data linearly from Capture to FSM, which dynamically routes outputs to four concurrent downstream channels based on configuration.

#### Core Component
* **Capture**: Ingests raw pixel data from the camera sensor.
* **Tracker**: Receives pixels, detects objects, and generates bounding box coordinates.
* **FSM (Finite State Machine)**: Evaluates system state to dictate output behavior.

#### Output Channel Behaviors
* **HDMI Display**: Opt-in visual preview. Controlled via sink_pipeline.
* **Network (UDP:5004)**: Always-on JSON feed. Emits bounding boxes and acts as a liveness heartbeat during idle states.
* **Recording**: Opt-in storage. Saves evidence MP4 files alongside synchronized bbox.csv telemetry.
* **Streaming**: Opt-in transmission. Delivers low-latency RTP H.264 video streams to a connected network peer.

<br>

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
## Setting Operation Modes
 
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





