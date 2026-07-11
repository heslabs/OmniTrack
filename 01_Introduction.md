# OmniTrack Introduction
### On-device tracking of drone target

---
## Description

On-device tracking enables unmanned aerial vehicles (UAVs) to autonomously follow targets using local processing, transforming raw sensor data into immediate flight control actions. This capability has evolved from basic pixel tracking to advanced AI systems that understand natural language commands.

### System Architectures

#### Visual Tracking (AI & Computer Vision)
* **Onboard Edge Computing**: Processors run lightweight models locally to eliminate latency and dependency on ground control stations.
* **Efficient AI Models**: Systems use optimized architectures like YOLOv8 or centroid-based trackers to generate real-time target bounding boxes.
* **Control Loop Feedback**: Proportional-Integral-Derivative (PID) controllers calculate the target's pixel offset from the frame center.
* **Gimbal & Flight Adjustments**: Algorithms translate spatial errors into instant correction signals for the camera gimbal and flight controller.

#### Sensor-Fusion & Advanced Spatial Targeting
* **Mathematical Ranging**: Systems like SPARC AI calculate coordinates using trigonometry, drone altitude, terrain elevation, and camera angles.
* **Multimodal Fusing**: Hardware merges data from Acoustic Beamforming, LiDAR, and Visual AI to maintain a continuous tracking state.
* **Occlusion Handling**: Combined sensor inputs predict target paths when subjects are hidden behind buildings, trees, or terrain.

#### Cognitive Tracking (LLMs, VLMs, & VLAs)
* **Vision-Language-Action (VLA)**: Models bridge the gap between perception and execution by mapping visual inputs directly to flight maneuvers.
* **Hybrid LLM-Vision Systems**: Onboard logic processes complex environment semantics alongside real-time video telemetry.
* **Natural Language Control**: Operators issue open-ended voice or text commands (e.g., "Follow the red vehicle that just turned left").
* **Zero-Shot Targeting**: AI identifies and tracks novel targets on the fly without requiring predefined bounding boxes or prior training. 

---
## Example Platforms

* Chipset: Qualcomm Dragonwing™ [QCS6490](https://www.qualcomm.com/internet-of-things/products/q6-series/qcs6490)
* Boards: Radxa Dragon [Q6A](https://radxa.com/products/dragon/q6a/)

<br>
<img width="350" height="220" alt="image" src="https://github.com/user-attachments/assets/e1c9f73e-5383-4db7-97e0-a4b79d79d074" />


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
<img width="2880" height="1620" alt="image" src="https://github.com/user-attachments/assets/844e2227-b8bf-4105-b5df-fbd93a1836eb" />

<br>
<img width="600" height="250" alt="image" src="https://github.com/user-attachments/assets/5a571737-f6b0-46b8-af01-9cc0796d9611" />

<br>
<img width="600" height="250" alt="image" src="https://github.com/user-attachments/assets/34299713-848e-480a-9c91-93745414792f" />


---
## Test Results

### Recorded output video

<img width="850" height="550" alt="image" src="https://github.com/user-attachments/assets/36025290-fb19-46ce-923c-0ed67100a215" />


### Power consumption

* Measured power comsumption in operation mode: < 5W (12V@0.42A)

<img width="450" height="250" alt="image" src="https://github.com/user-attachments/assets/5dad1a63-616d-43f8-a8b2-7304ad569e03" />


----
## Resources

* Cognitive Drone: A Vision-Language-Action Model & Benchmark for UAV Cognitive Reasoning [[Github]](https://cognitivedrone.github.io)
* UAV-Track VLA: Embodied Aerial Tracking via Vision-Language-Action Models [[arxiv]](https://arxiv.org/abs/2604.02241)





