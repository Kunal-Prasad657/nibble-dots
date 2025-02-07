
# hypr.danna ✨(ﾉ◕ヮ◕)ﾉ*:･ﾟ✧

## Information

<img src="https://github.com/notdanna/hypr.pro/blob/main/assets/ss.png?raw=true" width="100%">
<img src="https://github.com/notdanna/hypr.pro/blob/main/assets/ss1.png?raw=true" width="100%">
<img src="https://github.com/notdanna/hypr.pro/blob/main/assets/bar.gif?raw=true" width="100%">

## Introduction (o˘◡˘o)❀

Welcome, fellow Arch Linux adventurer! These are my dotfiles for **Hyprland** on Arch Linux.  
Here, you’ll find all the config files and scripts you need to get my custom theme up and running.  

> **Note**: I haven’t tested this on systems with NVIDIA, so results may vary. (≧∇≦)ﾉ

## Requirements 🛠️
- **Hyprland** (Wayland)  
- **Arch Linux** (or Arch-based)  
- **Zsh** (version 5.9 or higher)  
- **Kitty** (version 0.35.2 or higher)  
- **Desktop Manager** (optional; I use `emptty`)

## Important Details ⚠️
- **Monitor Settings**: Replace **your** monitor name in the Hyprland config files.  
- **Fonts**: I use some custom fonts. You’ll need to install them manually.

---

## Installation Steps (•̀ᴗ•́)و ̑̑

### 1. Clone the Repository and Run the Script

```bash
git clone https://github.com/danxnya/hypr.pro.git
cd hypr.pro/
chmod +x setup.sh
./setup.sh
```

### 2. Install the Required Fonts
```bash
mkdir ~/fonts/
```
1. [Download the fonts (MEGA)](https://mega.nz/file/GxFVSLLY#etuNc6QRrEl6wgl_ZatvomojDhkBTFPqlKS7ELk7KAM) into `~/fonts`  
2. Unzip the **fonts.zip** in the `~/fonts` directory:
   ```bash
   cd ~/fonts/ 
   unzip fonts.zip
   ```
3. Copy the fonts to your system directory (and optionally refresh the font cache):
   ```bash
   sudo cp -r ~/fonts/* /usr/share/fonts/
   fc-cache -v
   ```
   > **Note**: You can also place them in `~/.local/share/fonts/` if you prefer user-specific fonts.

### 3. (Optional) Install a Desktop Manager (｡•̀ᴗ-)✧
If you want to use `emptty` as your display manager:

```bash
sudo pacman -S emptty
sudo systemctl enable emptty.service
```

## Usage (o^▽^o)
1. Reboot and log in to the **Wayland** session with **Hyprland**.  
2. Make sure your monitor name is correctly set in the Hyprland configs (usually under `~/.config/hypr/`).  
3. Enjoy your cozy new environment! ✨

---

## Author ( •̀ᴗ•́ )و ̑̑
**notdanna**  
[Original Repository](https://github.com/notdanna/hypr.pro)
