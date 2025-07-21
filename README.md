
# 

<img src="https://github.com/Kunal-Prasad657/nibble-dots/blob/main/assets/2025-07-20-190200_hyprshot.png?raw=true" width="100%">
<img src="https://github.com/Kunal-Prasad657/nibble-dots/blob/main/assets/2025-07-21-203829_hyprshot.png?raw=true" width="100%">
<img src="https://github.com/Kunal-Prasad657/nibble-dots/blob/main/assets/r.png?raw=true" width="100%">
<img src="https://github.com/Kunal-Prasad657/nibble-dots/blob/main/assets/task.png?raw=true" width="100%">

## Introduction

Welcome, MAte this is a custom Arch Linux configuration file for Hyprland.


> **Note**: This is not tested on systems with NVIDIA.

## Requirements 🛠️
- **Hyprland** (Wayland)  
- **Arch Linux** (or Arch-based)  
- **Zsh** (version 5.9 or higher)  
- **Kitty** (version 0.35.2 or higher)  
- **Desktop Manager** 

## Important Details ⚠️
- **Monitor Settings**: Replace **your** monitor name in the Hyprland config files.  
[Run this command to get your monitor name]
```
hyprctl monitors all
```
and change the monitor name in the Hyprland config files.ie-

~/.config/hypr/src/monitor.conf

```
monitor=eDP-1,1920x1080@144,1920x1080@144,1 #replace with ur monitor name
```


- **Fonts**: I use some custom fonts. You’ll need to install them manually.

---

## Installation Steps 

### 1. Clone the Repository and Run the Script

```bash
git clone https://github.com/notdanna/hypr.pro.git
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

### 3. (Optional) Install a Desktop Manager 
If you want to use `emptty` as your display manager:

```bash
sudo pacman -S emptty
sudo systemctl enable emptty.service
```

## Usage
1. Reboot and log in to the **Wayland** session with **Hyprland**.  
2. Make sure your monitor name is correctly set in the Hyprland configs (usually under `~/.config/hypr/`).  
---

# 📜 Hyprland Keybinds

### 🖱️ Mouse Actions
| Key Combination | Action |
|----------------|--------|
| `SUPER + Left Click` | Move window |
| `SUPER + Right Click` | Resize window |

### 🖥️ Window Management
| Key Combination | Action |
|----------------|--------|
| `SUPER + Q` | Kill active window |
| `SUPER + SHIFT + F` | Toggle fullscreen |
| `SUPER + P` | Toggle pseudo mode |
| `SUPER + S` | Toggle floating mode |

### 📂 Applications & System
| Key Combination | Action |
|----------------|--------|
| `SUPER + RETURN` | Launch `ghostty` terminal |
| `SUPER + F1` | Launch `kitty` quick terminal |
| `SUPER + A` | Open Rofi (`drun`) |
| `SUPER + E` | Open file manager (`$fileManager`) |
| `SUPER + ESCAPE` | Suspend system (`systemctl suspend`) |
| `SUPER + SHIFT + ESCAPE` | Exit Hyprland |

### 🎨 Theming & Wallpapers
| Key Combination | Action |
|----------------|--------|
| `SUPER + SHIFT + W` | Execute `swww.sh` (wallpaper script) |
| `SUPER + SHIFT + O` | Execute `hyprswitch.sh` |

### 📝 Scripts & Utilities
| Key Combination | Action |
|----------------|--------|
| `SUPER + V` | Open clipboard manager (`cliphist.sh`) |
| `SUPER + PERIOD` | Open emoji picker (`emoji.sh`) |
| `SUPER + T` | Open Tmux session (`tmux.sh`) |
| `SUPER + N` | Open notes script (`notes.sh`) |
| `SUPER + SHIFT + T` | Open ToDo list (`todo.sh`) |
| `SUPER + MOD + I` | Open calendar (`calendar.sh`) |
| `SUPER + MOD + ,` | Open wallpaper manager (`wallpaper.sh`) |
| `SUPER + MOD + N` | Open network manager (`network.py`) |


### 🎥 Screenshots & Recording
| Key Combination | Action |
|----------------|--------|
| `SUPER + SHIFT + S` | Take a region screenshot (`hyprshot -m region`) |
| `SUPER + SHIFT + A` | Take a window screenshot (`hyprshot -m window`) |
| `SUPER + R` | Start screen recording (`wf-recorder`) |
| `SUPER + SHIFT + R` | Stop screen recording (`pkill wf-recorder`) |
| `SUPER + SHIFT + P` | Pick color from screen (`hyprpicker -a`) |

### 🔊 Audio & Media Controls
| Key Combination | Action |
|----------------|--------|
| `XF86AudioPlay` | Play/Pause media (`playerctl play-pause`) |
| `XF86AudioPrev` | Previous track (`playerctl previous`) |
| `XF86AudioNext` | Next track (`playerctl next`) |
| `XF86AudioMedia` | Play/Pause media |
| `XF86AudioStop` | Stop media |

### 🔀 Window Navigation
| Key Combination | Action |
|----------------|--------|
| `SUPER + J` | Move focus down |
| `SUPER + K` | Move focus up |
| `SUPER + H` | Move focus left |
| `SUPER + L` | Move focus right |

### ↔️ Resize Windows
| Key Combination | Action |
|----------------|--------|
| `SUPER + LEFT` | Decrease width |
| `SUPER + RIGHT` | Increase width |
| `SUPER + UP` | Decrease height |
| `SUPER + DOWN` | Increase height |

### 📦 Move Windows
| Key Combination | Action |
|----------------|--------|
| `SUPER + SHIFT + H` | Move window left |
| `SUPER + SHIFT + L` | Move window right |
| `SUPER + SHIFT + K` | Move window up |
| `SUPER + SHIFT + J` | Move window down |

### 🔢 Workspaces
| Key Combination | Action |
|----------------|--------|
| `SUPER + 1` | Switch to workspace 1 |
| `SUPER + 2` | Switch to workspace 2 |
| `SUPER + 3` | Switch to workspace 3 |
| `SUPER + 4` | Switch to workspace 4 |
| `SUPER + 5` | Switch to workspace 5 |
| `SUPER + 6` | Switch to workspace 6 |
| `SUPER + 7` | Switch to workspace 7 |
| `SUPER + 8` | Switch to workspace 8 |
| `SUPER + 9` | Switch to workspace 9 |
| `SUPER + 0` | Switch to workspace 0 |

### 🚀 Move Windows to Workspaces
| Key Combination | Action |
|----------------|--------|
| `SUPER + SHIFT + 1` | Move window to workspace 1 |
| `SUPER + SHIFT + 2` | Move window to workspace 2 |
| `SUPER + SHIFT + 3` | Move window to workspace 3 |
| `SUPER + SHIFT + 4` | Move window to workspace 4 |
| `SUPER + SHIFT + 5` | Move window to workspace 5 |
| `SUPER + SHIFT + 6` | Move window to workspace 6 |



---

## Author ( •̀ᴗ•́ )و ̑̑
**notdanna**  
[Original Repository](https://github.com/notdanna/hypr.pro)
