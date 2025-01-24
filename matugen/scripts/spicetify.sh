#!/bin/bash

if pgrep spotify; then
    spicetify watch -s & sleep 1 && pkill spicetify &
else
  spicetify config inject_css 1 inject_theme_js 1 replace_colors 1 overwrite_assets 1
  spicetify config color_scheme mocha
  spicetify apply
fi
