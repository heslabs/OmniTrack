# Integration Guide


---
## Camera — MIPI CSI-2
MIPI CSI-2, 2/4-lane; USB fallback.
* Standard: MIPI CSI-2 · NV12 720p30
* Hardware: 2-lane J16 / 4-lane J14, 3.3V & 5V.
* Fallback: USB camera (v4l2)

#### Pinout — MIPI CSI (J14, 4-lane)
* The MIPI CSI-2 lanes on J14 — 4 data pairs + clock.

<br>
<img width="650" height="300" alt="image" src="https://github.com/user-attachments/assets/00c88409-4ab7-4f1c-a2c0-07846bb9d1e5" />


---
## FCS Link — UART / MAVLink

* UART → FCS TELEM2 @115200 8N1; bridge bbox → MAVLink.
* UART to the flight controller — TX pin 16, RX pin 18 (QUPSE6).

```
## Serial wiring
Board UART2 TELEM2 · 115200 8N1 ·
/dev/ttyHS*.
```
#### Pinout — FCS UART (J20)
* UART to the flight controller — TX pin 16, RX pin 18 (QUPSE6).
  
<br>
<img width="800" height="300" alt="image" src="https://github.com/user-attachments/assets/99f00b4d-b1e2-45dc-8933-9a4f6e43c508" />



---
## Video Downlink

* RTP H.264 to the ground.
* Latency: ≈150 ms on LAN; +50–200 ms over radio.

<br>
<img width="800" height="100" alt="image" src="https://github.com/user-attachments/assets/adfab998-7efa-46bc-93d8-f8ce88e0799e" />
