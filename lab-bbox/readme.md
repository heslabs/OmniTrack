# BBox Selector

An interactive bounding-box selector built with [Gradio](https://www.gradio.app/).

Upload a video, choose a frame, then **click once** for the top-left corner and **click again** for the bottom-right corner. The box is drawn on the frame and the sliders sync automatically. Sliders remain available for fine-tuning, and the current box is shown as a copy/paste-ready snippet.

### Features
* Upload a video (`.mp4`, `.avi`, `.mov`, `.mkv`) and scrub through frames.
* Two-click bounding-box selection directly on the preview image.
* Fine-tune the box with center-X / center-Y / width / height sliders.
* Live coordinate readout (top-left and bottom-right corners).
* Bounding-box output formatted as `x y w h` (top-left + size).

### Requirements

* **Python** 3.10+ (the code uses `X | Y` type-hint syntax).
* **ffmpeg / ffprobe** available on your `PATH` (used to read video info and extract frames).
* Python packages listed in [requirements-bbox-selector.txt](requirements-bbox-selector.txt):
  * `gradio==6.15.2`
  * `pillow==12.2.0`


---
### Install bbox_selector

```
## Create a new environment with Python 3.10
$ conda create -n bbox-selector python=3.10 -y
## To activate this environment, use
$ conda activate bbox-selector                                                                                
## To deactivate an active environment, use                                                                          
$ conda deactivate
## Install ffmpeg (provides both ffmpeg and ffprobe)
$ sudo apt update && sudo apt install ffmpeg -y
## Install the Python dependencies
$ pip install -r requirements-bbox-selector.txt
```

---
### Luanch bbox_selector

Start the app:
```
$ python bbox_selector.py
```

The server launches on all interfaces at port **8501**:
```
$ google-chrome http://localhost:8501
```

Then in the browser

1. **Upload a video** using the file picker.
2. Use the **Frame index** slider to pick a frame.
3. **Click once** on the image to set the top-left corner (a yellow crosshair
   marks it).
4. **Click again** to set the bottom-right corner — the green box is drawn.
5. Optionally fine-tune with the **reticle_cx / cy / w / h** sliders.
6. Copy the value from the **Bounding Box output** box (format: `x y w h`,
   i.e. top-left corner plus width and height).

<br>
<img width="850" height="450" alt="image" src="https://github.com/user-attachments/assets/e0fecd93-2ebc-4134-8527-e7eee37b664a" />

<br>
<img width="850" height="450" alt="image" src="https://github.com/user-attachments/assets/1a7045d9-c0b3-4d80-ae69-b413bef76a9e" />

<br>
<img width="850" height="450" alt="image" src="https://github.com/user-attachments/assets/58f518ab-1a50-4ec2-9bc0-c6349f5f8876" />

<br>
 
<img width="850" height="450" alt="image" src="https://github.com/user-attachments/assets/1ebf8f8e-6404-4529-b064-ef2e1f1e33c2" />
 

```
## frame 1
## Bounding Box output (x y w h — top-left corner + size)
544 455 91 63
## Reticle output (cx cy w h — center + size)
589 486 91 63
```


---
### Configuration

Server host/port are set at the bottom of [bbox_selector.py](bbox_selector.py):

```python
demo.launch(server_name="0.0.0.0", server_port=8501, share=False)
```

* Change `server_port` to use a different port.
* Set `share=True` to create a temporary public Gradio link.

