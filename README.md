# OmniTrack
**On-device tracking of drone target**

---
## Description

On-device tracking enables unmanned aerial vehicles (UAVs) to autonomously follow targets using local processing, transforming raw sensor data into immediate flight control actions. This capability has evolved from basic pixel tracking to advanced AI systems that understand natural language commands.

### Core Processing Architectures

#### Visual Tracking (AI & Computer Vision)
* Onboard Edge Computing: Processors run lightweight models locally to eliminate latency and dependency on ground control stations.
* Efficient AI Models: Systems use optimized architectures like YOLOv8 or centroid-based trackers to generate real-time target bounding boxes.
* Control Loop Feedback: Proportional-Integral-Derivative (PID) controllers calculate the target's pixel offset from the frame center.
* Gimbal & Flight Adjustments: Algorithms translate spatial errors into instant correction signals for the camera gimbal and flight controller.

#### Sensor-Fusion & Advanced Spatial Targeting
* Mathematical Ranging: Systems like SPARC AI calculate coordinates using trigonometry, drone altitude, terrain elevation, and camera angles.
* Multimodal Fusing: Hardware merges data from Acoustic Beamforming, LiDAR, and Visual AI to maintain a continuous tracking state.
* Occlusion Handling: Combined sensor inputs predict target paths when subjects are hidden behind buildings, trees, or terrain.

#### Cognitive Tracking (LLMs, VLMs, & VLAs)
* Vision-Language-Action (VLA): Models bridge the gap between perception and execution by mapping visual inputs directly to flight maneuvers.
* Hybrid LLM-Vision Systems: Onboard logic processes complex environment semantics alongside real-time video telemetry.
* Natural Language Control: Operators issue open-ended voice or text commands (e.g., "Follow the red vehicle that just turned left").
* Zero-Shot Targeting: AI identifies and tracks novel targets on the fly without requiring predefined bounding boxes or prior training. 

---
## Example Platforms

* Chipset: Qualcomm Dragonwing™ [QCS6490](https://www.qualcomm.com/internet-of-things/products/q6-series/qcs6490)
* Boards: Radxa Dragon [Q6A](https://radxa.com/products/dragon/q6a/)

### Tech Specs
* **SoC**: Qualcomm® QCS6490
* **CPU**: 1× Kryo Prime @ 2.7GHz, 3× Kryo Gold @ 2.4GHz, 4× Kryo Silver @ 1.9GHz
* **GPU**: Qualcomm® Adreno 643, OpenGL® ES 3.2, 2.0, 1.1, Vulkan® 1.1 / 1.2 / 1.3, OpenCL™ 2.2, DirectX Feature Level 12
* **AI**: Total AI compute performance: 12 TOPS, Hexagon DSP with dual HVX, Hexagon Tensor Accelerator, Hexagon Coprocessor 2.0
* **RAM**: 12GB LPDDR5 @ 5500MT/s
* **Storage**: SPI Flash (bootloader), eMMC Module: 16GB, UFS Module: 128GB, MicroSD card slot ×1
* **Display**: HDMI 2.0: up to 4K@30Hz, MIPI DSI: 1× 4-lane
* **Camera**: MIPI CSI: 1× 4-lane, MIPI CSI: 2× 2-lane
* **Wireless**: Wi-Fi 6 (802.11 a/b/g/n/ac/ax), Bluetooth® 5.4 with BLE, Quectel FCU760K Module (AIC8800D80 chipset), 2× external antenna connectors
* **Ethernet**: 1× Gigabit Ethernet with PoE support (via optional HAT)
* **USB**: 1× USB 3.1 Type-A OTG, 3x USB 2.0 Type-A HOST, 1× USB 2.0 Type-C Power
* **Expansion**: M.2 M Key: PCIe Gen3 x2 (supports 2230 NVMe SSDs), 40-pin 2.54mm GPIO header, UART/I2C/SPI/GPIO/PWM, 2×5V in/out, 2×3.3V out
* **Audio**: 3.5mm audio jack
* **Power**: 12V via USB Type-C or Power input header, Recommended: ≥18W light load, ≥24W full load
* **Software**: Supports Radxa OS, Ubuntu Linux, Qualcomm Yocto Linux, Armbian, Arch, Deepin, Fedora, Windows
* **Dimensions**: 85 mm x 56 mm

---
<br>
<img width="300" height="200" alt="image" src="https://github.com/user-attachments/assets/e1c9f73e-5383-4db7-97e0-a4b79d79d074" />

<br>
<img width="2880" height="1620" alt="image" src="https://github.com/user-attachments/assets/844e2227-b8bf-4105-b5df-fbd93a1836eb" />

<br>
<img width="600" height="250" alt="image" src="https://github.com/user-attachments/assets/5a571737-f6b0-46b8-af01-9cc0796d9611" />

<br>
<img width="600" height="250" alt="image" src="https://github.com/user-attachments/assets/34299713-848e-480a-9c91-93745414792f" />



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



---
### Troubleshooting

#### Check for Missing Linux Live555 Packages (Linux Users)
Many Linux distributions (such as Ubuntu, Debian, or Linux Mint) strip the live555 library out of the default VLC repository package due to licensing and maintainer changes. Without it, VLC cannot handle standard RTSP streams and passes them to SAT>IP.

* Fix for Ubuntu/Debian/Mint: Install the missing multimedia streaming library or transition to the official Snap/Flatpak package which bundles it natively:
```
sudo apt update
sudo apt install livemedia-utils
```

If that fails, uninstall the APT version and install the Snap version:
```
sudo apt remove vlc
sudo snap install vlc
```

Verify with FFmpeg: To ensure the SAT>IP tuner is working, try running ffplay in your terminal.
```
ffplay -rtsp_transport tcp "rtsp://your-sat-ip-address"
```

#### Check Local and Network Firewalls
A firewall blocking the RTSP port (typically 554 or 8554) will drop the negotiation mid-session.
Linux: If running ufw, allow the RTSP port:
```
sudo ufw allow 554/tcp
```

#### Check if the Port is Listening
```
sudo lsof -i :8554
```

Result: If no lines are returned, your streaming server is not running or failed to bind to that port.

```
demo@cxa:~/labs/qcom6a/mediamtx$ sudo lsof -i :8554
COMMAND      PID USER   FD   TYPE  DEVICE SIZE/OFF NODE NAME
mediamtx 1432846 demo    7u  IPv6 2383002      0t0  TCP *:8554 (LISTEN)
mediamtx 1432846 demo   18u  IPv6 2375608      0t0  TCP localhost:8554->localhost:34352 (ESTABLISHED)
ffmpeg   1436824 demo    4u  IPv4 2391288      0t0  TCP localhost:34352->localhost:8554 (ESTABLISHED)
```

#### Switch VLC from UDP to TCP

RTSP often drops packets over UDP, causing VLC to fail the initial handshake. Forced TCP configuration fixes this.
* Open VLC.
* Go to Tools > Preferences (or Ctrl + P).
* At the bottom left under Show settings, select All.
* Navigate to Input / Codecs > Demuxers > RTP/RTSP.
* Check the box for Tunnel RTSP and RTP over HTTP or change the RTP transport protocol to TCP.
* Click Save and restart VLC.

 
#### Verify Port AvailabilityThe RTSP server might have failed to bind to port 8554. Check if the port is listening

```
netstat -tuln | grep 8554 or ss -tuln
```

#### Test Connection with Netcat or Telnet
Confirm that your system can physically reach the port
```
nc -zv 127.0.0.1 8554
```

Result:
```
Connection to 127.0.0.1 8554 port [tcp/*] succeeded!
```

If this times out or says "Connection refused", the streaming server is not running properly.

#### Change the Protocol in VLC
Sometimes VLC struggles with automatic UDP/TCP switching for RTSP. Force VLC to use TCP
* Open VLC media player.Go to Tools > Preferences (or Ctrl + P).
* Select All under Show settings at the bottom left.
* Expand Input / Codecs > Demuxers > RTP/RTSP.
* Check the box for Use RTP over RTSP (TCP).
* Click Save and restart VLC.


