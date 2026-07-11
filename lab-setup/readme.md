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



