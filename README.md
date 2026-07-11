# OmniTrack
### On-device tracking of drone target

---
## Description

On-device tracking enables unmanned aerial vehicles (UAVs) to autonomously follow targets using local processing, transforming raw sensor data into immediate flight control actions. This capability has evolved from basic pixel tracking to advanced AI systems that understand natural language commands.

### System Architectures

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

<br>
<img width="350" height="220" alt="image" src="https://github.com/user-attachments/assets/e1c9f73e-5383-4db7-97e0-a4b79d79d074" />


### Tech Specs
* **SoC**: Qualcomm® QCS6490
* **CPU**: 1× Kryo Prime @ 2.7GHz, 3× Kryo Gold @ 2.4GHz, 4× Kryo Silver @ 1.9GHz
* **GPU**: Qualcomm® Adreno 643, OpenGL® ES 3.2, 2.0, 1.1, Vulkan® 1.1 / 1.2 / 1.3, OpenCL™ 2.2, DirectX Feature Level 12
* **AI**: Total AI compute performance: 12 TOPS, Hexagon DSP with dual HVX, Hexagon Tensor Accelerator, Hexagon Coprocessor 2.0
* **RAM**: 12GB LPDDR5 @ 5500MT/s

---
## Test Results

### Recorded output video
* Youtube Video [[YT]](https://youtu.be/GfsY-D23dP4)

<img width="850" height="550" alt="image" src="https://github.com/user-attachments/assets/36025290-fb19-46ce-923c-0ed67100a215" />


### Power consumption

* Measured power comsumption in operation mode: < 5W (12V@0.42A)

<img width="450" height="250" alt="image" src="https://github.com/user-attachments/assets/5dad1a63-616d-43f8-a8b2-7304ad569e03" />


----
## Resources

* Cognitive Drone: A Vision-Language-Action Model & Benchmark for UAV Cognitive Reasoning [[Github]](https://cognitivedrone.github.io)
* UAV-Track VLA: Embodied Aerial Tracking via Vision-Language-Action Models [[arxiv]](https://arxiv.org/abs/2604.02241)





