#!/usr/bin/env zsh

XDG_CONFIG_HOME="$HOME/.config"
GNUPGHOME="$HOME/.config/gnupg"

# shellcheck source=/home/mustaqim/.priv-env
source "$HOME/.priv-env"

# ===  VARIABLES  === {{{

export XDG_SESSION_TYPE=x11
# export XDG_SESSION_TYPE=wayland
#export XDG_CURRENT_DESKTOP=KDE
export KDE_SESSION_VERSION=5
export XDG_SESSION_CLASS=user

export AWESOME_THEMES_PATH="/home/mustaqim/.config/awesome/themes/"
# export KDEWM=/usr/bin/awesome
export QT_QPA_PLATFORMTHEME=qt5ct
# export QT_QPA_PLATFORM=wayland
export XCURSOR_PATH=$HOME/.local/share/icons
export XCURSOR_THEME="Breeze_Snow"

# export BROWSER="$HOME/.local/bin/firefox/firefox"
export BROWSER="firefox"
#export MOZ_USE_XINPUT2=1
# export MOZ_ACCELERATED=1
# export MOZ_WEBRENDER=1
# export MOZ_X11_EGL=1
export MOZ_ENABLE_WAYLAND=1

export LC_ALL=C
export TZ=Africa/Johannesburg

LC_ALL="en_ZA.UTF-8"

export LIBVA_DRIVER_NAME=iHD_drv_video

#export ALTERNATE_EDITOR=""
export EDITOR="emacsclient -nw"
#export VISUAL="emacsclient -c -a emacs"

export TERM=xterm-256color
export COLORTERM=truecolor

export FZF_DEFAULT_COMMAND="fd -L . --min-depth 1 -t f -t d -c always"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd -L . --min-depth 1 -t d -c always 2> /dev/null"
export FZF_DEFAULT_OPTS="--layout=reverse --ansi --color=bg+:#282a2e,bg:#1d1f21,spinner:#8abeb7,hl:#81a2be,fg:#b4b7b4,header:#81a2be,info:#f0c674,pointer:#8abeb7,marker:#8abeb7,fg+:#e0e0e0,prompt:#f0c674,hl+:#81a2be"
export ENHANCD_FILTER='fzf'
export ZSH_AUTOSUGGEST_USE_ASYNC=1
export FAST_ALIAS_TIPS_PREFIX="$(tput bold)╭───\n\033[01;33m   \033[01;37m"
export FAST_ALIAS_TIPS_SUFFIX="\n╰───$(tput sgr0)"

export GNUPGHOME=$HOME/.config/gnupg
export GPG_TTY=$(tty)
export MANPAGER='nvim +Man!'
# export MANPAGER="sh -c \'col -bx | bat -l man -p\'"
export MANPATH=/usr/share/man:/opt/texlive/2020/texmf-dist/doc/man
export RANGER_LOAD_DEFAULT_RC=FALSE
export XENVIRONMENT="${HOME}/.Xresources"
export DOCKER_HOST=127.0.0.1:2375
export DOOMDIR="~/.config/doom"

#export JAVA_HOME="/usr/lib/jvm/openjdk"
export JAVA_HOME="/usr/lib/jvm/jbrsdk"
export _JAVA_OPTIONS='-Dswing.defaultlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel -Dawt.useSystemAAFontSettings=on -Dswing.aatext=true'
#export CLASSPATH="/home/mustaqim/Downloads/perimeter/apache-csv.jar:courserajava.jar"
export _JAVA_AWT_WM_NONREPARENTING=1

# Less Colors for Man Pages
export LESS_TERMCAP_mb=$'\e[01;31m'       # begin blinking
export LESS_TERMCAP_md=$'\e[01;38;5;74m'  # begin bold
export LESS_TERMCAP_me=$'\e[0m'           # end mode
export LESS_TERMCAP_se=$'\e[0m'           # end standout-mode
export LESS_TERMCAP_so=$'\e[38;5;246m'    # begin standout-mode - info box
export LESS_TERMCAP_ue=$'\e[0m'           # end underline
export LESS_TERMCAP_us=$'\e[04;38;5;146m' # begin underline
export LESS_TERMCAP_so=$'\e[30;43m'       # search result
# }}}

export RUST_SRC_PATH="/home/mustaqim/.rustup/toolchains/nightly-x86_64-unknown-linux-gnu/lib/rustlib/src/rust/src"
export ANDROID_HOME="$HOME/Android/Sdk"

export path=(
    $HOME/.cargo/bin
    $HOME/.yarn/bin
    $HOME/.emacs.d/bin
    $HOME/.local/bin
    $HOME/.local/bin/sml/bin
    $HOME/.local/bin/language-servers/kotlin-language-server/bin
    # $HOME/.local/bin/ktlint
    $HOME/.local/bin/scripts
    $ANDROID_HOME/tools
    $ANDROID_HOME/platform-tools
    /opt/texlive/2020/bin/x86_64-linux
    $JAVA_HOME/bin
    $path
    )

# remove duplicate entries
for i in $( echo $PATH | tr ":" "\n" | sort | uniq )
do
    PATH_SORT="${PATH_SORT}$i:"
done
PATH="${PATH_SORT%:}"

