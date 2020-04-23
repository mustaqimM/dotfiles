#!/bin/zsh


switch_theme() {
    if (( ! $# )); then
        echo "More args"
        exit 2
    fi
}

#sed 's|theme_tomorrow|theme_tomorrow_night|' .Xresources
#sed 's|base16/tomorrow|base16/tomorrow-night|;s|mojave-light|mojave|' ~/.config/vifm/vifmrc
#ln -sf ~/.local/themes/base16-tomorrow.sh ~/.base16_theme
