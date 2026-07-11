# Lab Setup

---
## Install conda

1. Download the installer
* Installing conda on Linux [[docs]](https://docs.conda.io/projects/conda/en/latest/user-guide/install/linux.html)
* Install Anaconda Distribution
  * Linux 64-Bit (x86_64) Installer: Anaconda3-2025.12-2-Linux-x86_64.sh
  * Linux 64-Bit (AWS Graviton2/ARM64) Installer

2. In your terminal window, run:
```
bash <conda-installer-name>-latest-Linux-x86_64.sh
bash ./Anaconda3-2025.12-2-Linux-x86_64.sh
```
* conda-installer-name will be one of "Miniconda3", "Anaconda", or "Miniforge3".

3. Follow the prompts on the installer screens. If you are unsure about any setting, accept the defaults. You can change them later. To make the changes take effect, close and then re-open your terminal window.

4. Test your installation. In your terminal window, run the command ```conda list``. A list of installed packages appears if it has been installed correctly.

```
conda list
# packages in environment at /home/demo/anaconda3:
# Name                           Version               Build               Channel
_anaconda_depends                2025.12               py313_mkl_0
```


---
## Install bbox_selector

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
## Luanch bbox_selector

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
```
## Bounding Box output (x y w h — top-left corner + size)
418 163 268 158
## Reticle output (cx cy w h — center + size)
552 242 268 158
```


---
#### Configuration

Server host/port are set at the bottom of [bbox_selector.py](bbox_selector.py):

```python
demo.launch(server_name="0.0.0.0", server_port=8501, share=False)
```

* Change `server_port` to use a different port.
* Set `share=True` to create a temporary public Gradio link.

