# hypr.danna

[![Demo GIF](https://i.postimg.cc/jqzQ4s6X/salida.gif)](https://postimg.cc/nMhDHfPj)

## Introduction

Welcome! These are my dotfiles for Hyprland on Arch Linux.  
In this repository, you will find the configuration and scripts needed to install my theme.  
> **Note**: I have not tested this configuration on systems with NVIDIA, so I cannot guarantee it will work there.

## Requirements

1. **Hyprland** (Wayland)  
2. **Arch Linux** (or Arch-based)  
3. **Zsh** (version 5.9 or higher)  
4. **Kitty** (version 0.35.2 or higher)  
5. **Desktop Manager** (optional, I use `emptty`)

## Important Details

- **Monitor Settings**: Make sure you replace your monitor name in the Hyprland configuration files.
- **Fonts**: Some custom fonts are used in this configuration. They must be installed manually.

## Installation Steps

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

1. Download the fonts archive from the following link on ~/fonts :  
   [Fonts (MEGA)](https://mega.nz/file/GxFVSLLY#etuNc6QRrEl6wgl_ZatvomojDhkBTFPqlKS7ELk7KAM)

2. Unzip the **fonts.zip** into ~/fonts/ directory:

   ```bash
   cd ~/fonts/ 
   unzip fonts.zip
   ```

3. Copy the fonts to the system directory (and optionally update your font cache):

   ```bash
   sudo cp -r ~/fonts/* /usr/share/fonts/
   fc-cache -v
   ```

   > **Note**: You can also store fonts under `~/.local/share/fonts/` (or `~/.fonts/`) if you prefer per-user installations.

### 3. (Optional) Install a Desktop Manager

This setup can work with any display manager or login manager. If you want to use `emptty`:

```bash
sudo pacman -S emptty
sudo systemctl enable emptty.service
```

## Usage

1. After rebooting, log in to the Wayland session with Hyprland.
2. Make sure your monitor name is set correctly in the configuration (located at `~/.config/hypr/` or wherever you placed it).
3. Enjoy your new customized environment!

## Author

**notdanna**  
[Original Repository](https://github.com/notdanna/hypr.pro)

---
