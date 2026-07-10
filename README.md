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
### MediaMTX


