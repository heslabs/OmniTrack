# OmniTrack




---
### RTSP Source (Laptop)

```
LAPTOP
# mediamtx on :8554, then publish:
ffmpeg -re -stream_loop -1 -i video.mp4 \
-c:v copy -an -f rtsp \
rtsp://127.0.0.1:8554/drone18
```


---
#### Quick Troubleshooting 

* Start your RTSP server: FFmpeg does not host the stream; it only pushes to a server. Ensure tools like MediaMTX (formerly rtsp-simple-server), Live555, or Nimble Streamer are running.
* Verify the port: Check your server configuration file to confirm it is actually using port 8554.
* Check local listener: Run netstat -ano | findstr 8554 (Windows) or sudo ss -tulpn | grep 8554 (Linux) to see if the port is actively open.
* Fix the FFmpeg syntax: If your server requires an active listen mode to receive the stream, add the ?listen parameter to your FFmpeg output URL.

Corrected FFmpeg Command ExampleIf you are using a server like MediaMTX, ensure the server executable is running in a separate terminal before running your FFmpeg command:
```
## bash
ffmpeg -re -i input.mp4 -c copy -f rtsp rtsp://127.0.0.1:8554/drone18
```

Use code with caution.If you want FFmpeg to act as the server itself (listening for a player to connect), add the listen flag:
```
## bash
ffmpeg -re -i input.mp4 -c copy -f rtsp -rtsp_flags listen rtsp://127.0.0
```

---
## MediaMTX

To start MediaMTX, run the standalone binary executable file or launch its official container, depending on your system setup.Execution MethodsUsing Standalone BinaryNavigate to the directory where you extracted the MediaMTX files and execute the command corresponding to your operating system:

```
git clone https://github.com/eyepop-ai/eyepop-mediamtx
```

### Installation
There are several installation methods available: standalone binary, Docker image, Arch Linux package and OpenWrt binary.

### Standalone binary
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


---
### Using Docker
If you prefer running it inside a containerized environment, pull and launch the official MediaMTX image with host networking mode:

```
docker run --rm -it --network=host bluenviron/mediamtx
```

---
### Using Linux Systemd Service
To manage it as a persistent background service on Linux distributions (like Ubuntu or Raspberry Pi OS), create a service file and initialize it via systemctl:

```
sudo systemctl daemon-reload
sudo systemctl enable --now mediamtx.service
```

---
### Verification

Once initialized, the terminal console will output active listener indicators showing operational status on the default ports:
* RTSP: Port 8554
* RTMP: Port 1935
* HLS: Port 8888
* WebRTC: Port 8889

