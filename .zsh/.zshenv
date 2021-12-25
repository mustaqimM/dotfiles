#!/usr/bin/env zsh

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"

export XDG_SESSION_TYPE=wayland
export XDG_CURRENT_DESKTOP=Unity
# KDE_SESSION_VERSION=5
# XDG_SESSION_CLASS=user

# AWESOME_THEMES_PATH="/home/mustaqim/.config/awesome/themes/"
# KDEWM=/usr/bin/awesome
export QT_QPA_PLATFORMTHEME=qt5ct
export QT_QPA_PLATFORM=wayland
# XCURSOR_PATH=$HOME/.local/share/icons
# XCURSOR_THEME="Breeze_Snow"
export GTK_USE_PORTAL=0

# export BROWSER="firefox"
export MOZ_ENABLE_WAYLAND=1

export TZ=Africa/Johannesburg

# export LC_ALL=C
export LC_ALL="en_ZA.UTF-8"

export LIBVA_DRIVER_NAME=i965

export EDITOR="emacsclient -nw"
# ALTERNATE_EDITOR=""
# VISUAL="emacsclient -c -a emacs"

export TERM=xterm-256color
export COLORTERM=truecolor

export FZF_DEFAULT_COMMAND="fd -L . --min-depth 1 -t f -t d -H -c always"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND --max-depth 1"
export FZF_ALT_C_COMMAND="fd -L . --min-depth 1 -t d -c always 2> /dev/null"
export FZF_DEFAULT_OPTS="--layout=reverse --ansi --prompt=' ' --pointer='›' --marker='›' --color=spinner:yellow,hl:red,info:yellow,pointer:yellow,marker:green,prompt:blue,hl+:red"
export ENHANCD_FILTER='fzf'
export ENHANCD_COMPLETION_BEHAVIOR=list
export ZSH_AUTOSUGGEST_USE_ASYNC=1
# FAST_ALIAS_TIPS_PREFIX="$(tput bold)╭───\n\033[01;33m   \033[01;37m"
# FAST_ALIAS_TIPS_SUFFIX="\n╰───$(tput sgr0)"

export GNUPGHOME=$HOME/.config/gnupg
export GPG_TTY=$(tty)
export MANPAGER='nvim +Man!'
# MANPAGER="sh -c \'col -bx | bat -l man -p\'"
export MANPATH=/usr/share/man:/opt/texlive/2020/texmf-dist/doc/man
export XENVIRONMENT="${HOME}/.Xresources"
export DOCKER_HOST=127.0.0.1:2375
export DOOMDIR="~/.config/doom"

# export JAVA_HOME="/usr/lib/jvm/openjdk"
export JAVA_HOME="/usr/lib/jvm/jbrsdk"
export _JAVA_OPTIONS='-Dswing.defaultlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel -Dawt.useSystemAAFontSettings=on -Dswing.aatext=true'
# export CLASSPATH="/home/mustaqim/Downloads/perimeter/apache-csv.jar:courserajava.jar"
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

# export RUST_SRC_PATH="/home/mustaqim/.rustup/toolchains/nightly-x86_64-unknown-linux-gnu/lib/rustlib/src/rust/src"
# export ANDROID_HOME="$HOME/Android/Sdk"

# shellcheck source=/home/mustaqim/.priv-env
# source "$HOME/.priv-env"

typeset -U path
path=(
    # $HOME/.cargo/bin
    # $HOME/.yarn/bin
    $HOME/.emacs.d/bin
    # $HOME/.local/bin/sml/bin
    # $HOME/.local/bin/language-servers/kotlin-language-server/bin
    # $HOME/.local/bin/ktlint
    $HOME/.local/bin/scripts
    # $ANDROID_HOME/tools
    # $ANDROID_HOME/platform-tools
    # /opt/texlive/2020/bin/x86_64-linux
    # $JAVA_HOME/bin
    $path
)
export PATH

# remove duplicate entries (not required if using the -U array flag)
# for i in $( echo $PATH | tr ":" "\n" | sort | uniq )
# do
#     PATH_SORT="${PATH_SORT}$i:"
# done
# PATH="${PATH_SORT%:}"
