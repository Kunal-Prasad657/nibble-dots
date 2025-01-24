#!/bin/bash

# Configuración base
CONFIG_DIR="$HOME/.config/waybar/"
DEFAULT_CONFIG="$CONFIG_DIR/config.jsonc"
DEFAULT_STYLE="$CONFIG_DIR/style.css"

# Detectar monitores activos con hyprctl o xrandr
if command -v hyprctl &> /dev/null; then
    ACTIVE_MONITORS=$(hyprctl monitors | grep "Monitor" | awk '{print $2}')
elif command -v xrandr &> /dev/null; then
    ACTIVE_MONITORS=$(xrandr --listactivemonitors | tail -n +2 | awk '{print $NF}')
else
    echo "Error: No se detectó hyprctl ni xrandr."
    exit 1
fi

# Asignar configuración según monitor
case "$ACTIVE_MONITORS" in
    *HDMI-A-1*)
        CONFIG="$CONFIG_DIR/config.jsonc"
        ;;
    *eDP-1*)
        CONFIG="$CONFIG_DIR/secondmonitor.jsonc"
        ;;
    *)
        CONFIG="$DEFAULT_CONFIG"
        ;;
esac
STYLE="$DEFAULT_STYLE"

# Cierra cualquier instancia previa de Waybar
echo "Reiniciando Waybar..."
pgrep -x waybar &>/dev/null && killall waybar

# Verifica existencia de archivos
if [[ ! -f "$CONFIG" ]]; then
    echo "Error: Configuración no encontrada en $CONFIG."
    exit 1
fi
if [[ ! -f "$STYLE" ]]; then
    echo "Error: Estilo no encontrado en $STYLE."
    exit 1
fi

# Inicia Waybar con la configuración correspondiente
waybar -c "$CONFIG" -s "$STYLE" &
if [[ $? -eq 0 ]]; then
    echo "Waybar iniciado correctamente con configuración en $CONFIG y estilo en $STYLE."
else
    echo "Error al iniciar Waybar. Revisa los logs."
    exit 1
fi

