#!/bin/bash -f

./mediamtx &
#sleep 3
# mediamtx on :8554, then publish:
ffmpeg -re -stream_loop -1 -i demo1a.mp4 -c:v copy -an -f rtsp \
rtsp://127.0.0.1:8554/drone
