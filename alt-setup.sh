#!/bin/bash

# -----------------------------------------------------------------------------
# Este script instala varios paquetes, actualiza el sistema, copia
# archivos de configuración (dotfiles) y configura preferencias del usuario.
# Funciona para Arch Linux y Fedora.
# SCRIPTED BY: notdanna - Adaptado por ChatGPT
# -----------------------------------------------------------------------------

# Detectar la distribución
if [ -f /etc/os-release ]; then
    . /etc/os-release
    DISTRO=$ID
else
    echo "No se pudo determinar la distribución."
    exit 1
fi

# Array de paquetes para Arch (usados con Yay)
install_packages_yay=(
    kitty
    hyprland
    waybar
    hyprshot
    hyprpicker
    grim
    slurp
    nautilus
    pamixer
    pavucontrol
    brightnessctl
    zsh
    lsd
    zsh-syntax-highlighting
    zsh-autosuggestions
    neovim
    wget
    unzip
    gtk3
    imagemagick
    rust
    zen-browser-bin
    wf-recorder
    rofi
    swww
    vesktop
    cliphist
    keyd
    ttf-jetbrains-mono-nerd
    hyprpicker
    rofi-calc
    rofimoji
    tmux
    adwaita-colors-icon-theme
    spicetify-cli
    swaync-git
    swaync-widgets-git
    gnome-tweaks
    python-pywal
    matugen-bin
    mpv
)

# Array de paquetes para Fedora (solo los disponibles oficialmente)
install_packages_dnf=(
    kitty
    waybar
    grim
    slurp
    nautilus
    pamixer
    pavucontrol
    brightnessctl
    zsh
    lsd
    zsh-syntax-highlighting
    zsh-autosuggestions
    neovim
    wget
    unzip
    gtk3
    imagemagick
    rust
    rofi
    tmux
    adwaita-icon-theme
    gnome-tweaks
    pywal
    mpv
)

# Archivo de log de instalación
INSTLOG="install.log"

function present() {
    local array=(
        "\040b"
        "y\040"
        "d"
        "a"
        "n"
        "n"
        "a"
        "l"
        "^"
        "^\n"
    )
    for letter in "${array[@]}"; do
        echo -en "\e[95m${letter}\e[0m"
        sleep 0.2
    done
}

# -----------------------------------------------------------------------------
# show_progress: Muestra progreso mientras un proceso en segundo plano se está ejecutando
# -----------------------------------------------------------------------------
function show_progress() {
    while ps -p "$1" &> /dev/null; do
        echo -n "."
        sleep 2
    done
    echo -en "\e[32mOK\e[0m"
    sleep 2
}

# -----------------------------------------------------------------------------
# install_software: Instala un paquete ($1) usando el gestor correspondiente
# -----------------------------------------------------------------------------
function install_software() {
    echo -en "$1"
    if [ "$DISTRO" == "arch" ]; then
        yay -S --noconfirm "$1" &>> "$INSTLOG" &
        show_progress $!
        if yay -Q "$1" &>> /dev/null; then
            echo -e ""
        else
            echo -e "$1 OH, NO! algo salió mal, por favor revisa el archivo: install.log"
            exit 0
        fi
    elif [ "$DISTRO" == "fedora" ]; then
        sudo dnf install -y "$1" &>> "$INSTLOG" &
        show_progress $!
        if rpm -q "$1" &>> /dev/null; then
            echo -e ""
        else
            echo -e "$1 OH, NO! algo salió mal, por favor revisa el archivo: install.log"
            exit 0
        fi
    fi
}

# -----------------------------------------------------------------------------
# update: Actualiza la base de datos de paquetes y actualiza el sistema
# -----------------------------------------------------------------------------
function update() {
    echo -en "Actualizando."
    if [ "$DISTRO" == "arch" ]; then
        sudo pacman -Syu --noconfirm &>> "$INSTLOG" &
        show_progress $!
    elif [ "$DISTRO" == "fedora" ]; then
        sudo dnf upgrade --refresh -y &>> "$INSTLOG" &
        show_progress $!
    fi
    echo -en "\n"
}

# -----------------------------------------------------------------------------
# packagemanager: Instala Yay si no está instalado (para Arch) o indica el gestor para Fedora
# -----------------------------------------------------------------------------
function packagemanager() {
    if [ "$DISTRO" == "arch" ]; then
        if [ ! -f /sbin/yay ]; then
            echo -en "Instalando yay."
            git clone https://aur.archlinux.org/yay-git &>> "$INSTLOG"
            cd yay-git || exit 1
            makepkg -si --noconfirm &>> ../"$INSTLOG" &
            show_progress $!
            if [ -f /sbin/yay ]; then
                :
            else
                echo -e "La instalación de yay falló, por favor revisa el archivo >< install.log"
                exit 0
            fi
            cd ..
        fi
    elif [ "$DISTRO" == "fedora" ]; then
        echo "Se utilizará DNF, no es necesaria la instalación de un gestor adicional."
    fi
}

# -----------------------------------------------------------------------------
# setup: Instala la lista de paquetes definida según la distribución
# -----------------------------------------------------------------------------
function setup() {
    echo -e "\n"
    if [ "$DISTRO" == "arch" ]; then
        echo -en "\e[33m[x] Instalando paquetes con Yay...\e[0m\n"
        for SOFTWR in "${install_packages_yay[@]}"; do
            if [ "$SOFTWR" == 'rustup' ]; then
                sudo pacman -R --noconfirm rust > /dev/null 2>&1
                install_software "$SOFTWR"
            else
                install_software "$SOFTWR"
            fi
        done
    elif [ "$DISTRO" == "fedora" ]; then
        echo -en "\e[33m[x] Instalando paquetes con DNF...\e[0m\n"
        for SOFTWR in "${install_packages_dnf[@]}"; do
            install_software "$SOFTWR"
        done
        echo -e "\n\e[31mAtención: Los siguientes paquetes NO se han integrado para Fedora (no se encontraron en repositorios oficiales):\e[0m"
        echo "hyprland, hyprshot, hyprpicker, zen-browser-bin, wf-recorder, swww, vesktop, cliphist, keyd, ttf-jetbrains-mono-nerd, rofi-calc, rofimoji, spicetify-cli, swaync-git, swaync-widgets-git, matugen-bin"
    fi
}

# -----------------------------------------------------------------------------
# copia: Copia dotfiles al directorio del usuario y configura ZSH y otros ajustes
# -----------------------------------------------------------------------------
function copia() {
    echo -en "\n"
    echo -en "\e[33m[x] Copiando configuración...\e[0m\n"
    echo -en "dots."

    mkdir -p "$HOME/.config" > /dev/null 2>&1

    mkdir -p "$HOME/.config/dunst" > /dev/null 2>&1
    cp -r "$1/dots/dunst/"* "$HOME/.config/dunst/"

    mkdir -p "$HOME/.config/fastfetch" > /dev/null 2>&1
    cp -r "$1/dots/fastfetch/"* "$HOME/.config/fastfetch/"

    mkdir -p "$HOME/.config/gtk-3.0" > /dev/null 2>&1
    cp -r "$1/dots/gtk-3.0/"* "$HOME/.config/gtk-3.0/"

    mkdir -p "$HOME/.config/gtk-4.0" > /dev/null 2>&1
    cp -r "$1/dots/gtk-4.0/"* "$HOME/.config/gtk-4.0/"

    mkdir -p "$HOME/.config/hypr" > /dev/null 2>&1
    cp -r "$1/dots/hypr/"* "$HOME/.config/hypr/"

    mkdir -p "$HOME/.config/kitty" > /dev/null 2>&1
    cp -r "$1/dots/kitty/"* "$HOME/.config/kitty/"

    mkdir -p "$HOME/.config/rofi" > /dev/null 2>&1
    cp -r "$1/dots/rofi/"* "$HOME/.config/rofi/"

    mkdir -p "$HOME/.config/spicetify/Themes" > /dev/null 2>&1
    cp -r "$1/dots/spicetify/"* "$HOME/.config/spicetify/Themes/"

    mkdir -p "$HOME/.config/vesktop/themes" > /dev/null 2>&1
    cp -r "$1/dots/vesktop/"* "$HOME/.config/vesktop/themes/"

    mkdir -p "$HOME/.config/waybar" > /dev/null 2>&1
    cp -r "$1/dots/waybar/"* "$HOME/.config/waybar/"

    sudo usermod --shell /usr/bin/zsh "$USER" > /dev/null 2>&1
    sudo usermod --shell /usr/bin/zsh root > /dev/null 2>&1
    cp -r "$1/dots/.zshrc" "$HOME/"
    sudo ln -s -f "$HOME/.zshrc" "/root/.zshrc"

    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k > /dev/null 2>&1
    sudo git clone --depth=1 https://github.com/romkatv/powerlevel10k.git /root/powerlevel10k > /dev/null 2>&1
    cp -r "$1/dots/powerlevel10k/user/.p10k.zsh" "$HOME/"
    sudo cp -r "$1/dots/powerlevel10k/root/.p10k.zsh" "/root/"

    cd /usr/share || exit 1
    sudo mkdir -p zsh-sudo
    sudo chown "$USER":"$USER" zsh-sudo/
    cd zsh-sudo || exit 1
    sudo cp -r "$1/dots/sudo.plugin.zsh" /usr/share/zsh-sudo/

    read -rp '¿Configurar keyd? Se cambiará la "ñ" por "-" (y,n)? ' KEYDANS
    if [[ "$KEYDANS" =~ ^[Yy]$ ]]; then
        sudo cp -r "$1/dots/default.conf" /etc/keyd/
    fi

    spicetify config current_theme catppuccin
    spicetify config color_scheme mocha
    spicetify config inject_css 1 inject_theme_js 1 replace_colors 1 overwrite_assets 1
    spicetify apply

    echo -en "\e[32mOK\e[0m\n"
}

# -----------------------------------------------------------------------------
# finalizacion: Mensaje final al completar la configuración
# -----------------------------------------------------------------------------
function finalizacion() {
    echo ""
    echo "Todo listo. Reinicia y disfruta :)"
    echo ""
}

# -----------------------------------------------------------------------------
# call: Ejecuta todas las funciones principales en orden
# -----------------------------------------------------------------------------
function call() {
    local ruta
    ruta="$(pwd)"
    update
    packagemanager
    setup "$ruta"
    copia "$ruta"
    finalizacion
}

# -----------------------------------------------------------------------------
# Lógica principal:
# Verifica que el script NO se ejecute como root y procede con la instalación
# -----------------------------------------------------------------------------
if [ "$(whoami)" != "root" ]; then
    present
    echo -en '\n'
    read -rep '¿Instalar? (y,n)? ' CONTINST

    if [[ "$CONTINST" == "Y" || "$CONTINST" == "y" || "$CONTINST" == "yes" ]]; then
        echo -en "\n"
        echo -en "\e[33m[x] Instalando >.<...\e[0m\n"
        sudo touch /tmp/hyprv.tmp
        call
    else
        echo -e "Saliendo del script, no se han realizado cambios en el sistema."
        exit 0
    fi
else
    echo 'Error, el script no debe ejecutarse como root.'
    exit 0
fi
