#!/usr/bin/env zsh

ZDOTDIR=/home/mustaqim/.zsh
. $ZDOTDIR/zshenv
ZSH_CACHE_DIR=$ZDOTDIR/cache

export PATH="$HOME/.cargo/bin:$HOME/.local/bin/sml/bin:$HOME/.yarn/bin:$HOME/.emacs.d/bin:$PATH"
export RUST_SRC_PATH="/home/mustaqim/.rustup/toolchains/nightly-x86_64-unknown-linux-gnu/lib/rustlib/src/rust/src"

# shellcheck source=/home/mustaqim/.priv-env
source "$HOME/.priv-env"

# ===  VARIABLES  === {{{

export XDG_SESSION_TYPE=x11
export XDG_CURRENT_DESKTOP=KDE
export KDE_SESSION_VERSION=5

export AWESOME_THEMES_PATH="$HOME/.config/awesome/themes"
export KDEWM=/usr/bin/awesome
export QT_QPA_PLATFORMTHEME=qt5ct

export BROWSER=firefox
export MOZ_ACCELERATED=1
export MOZ_WEBRENDER=1

export LC_ALL=C
export TZ=Africa/Johannesburg

LC_ALL="en_ZA.UTF-8"

#export ALTERNATE_EDITOR=""
#export EDITOR="emacsclient"
#export VISUAL="emacsclient -c -a emacs"

export FZF_DEFAULT_COMMAND="fd --type file --color=always"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd . -t d"
export FZF_TMUX_HEIGHT=80%
export SKIM_DEFAULT_OPTIONS="--color=bg+:#282a2e,bg:#1d1f21,spinner:#8abeb7,hl:#81a2be,fg:#b4b7b4,header:#81a2be,info:#f0c674,pointer:#8abeb7,marker:#8abeb7,fg+:#e0e0e0,prompt:#f0c674,hl+:#81a2be
  --ansi
  --reverse"
export SKIM_DEFAULT_COMMAND="$FZF_DEFAULT_COMMAND"
export ENHANCD_FILTER='fzf'
export ZSH_AUTOSUGGEST_USE_ASYNC=1
export FAST_ALIAS_TIPS_PREFIX="$(tput bold)╭──\n\033[01;33m 💡  \033[01;37m"
export FAST_ALIAS_TIPS_SUFFIX="\n╰──$(tput sgr0)"

export GNUPGHOME=$HOME/.config/gnupg
export GPG_TTY=$(tty)
export MANPAGER='nvim +Man!'
#export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export RANGER_LOAD_DEFAULT_RC=FALSE
export JAVA_HOME="/usr/lib/jvm/openjdk"
export _JAVA_OPTIONS='-Dswing.defaultlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel'
export XENVIRONMENT="${HOME}/.Xresources"
export DOCKER_HOST=127.0.0.1:2375
export DOOMDIR="~/.config/doom"

# Less Colors for Man Pages
export LESS_TERMCAP_mb=$'\e[01;31m'       # begin blinking
export LESS_TERMCAP_md=$'\e[01;38;5;74m'  # begin bold
export LESS_TERMCAP_me=$'\e[0m'           # end mode
export LESS_TERMCAP_se=$'\e[0m'           # end standout-mode
export LESS_TERMCAP_so=$'\e[38;5;246m'    # begin standout-mode - info box
export LESS_TERMCAP_ue=$'\e[0m'           # end underline
export LESS_TERMCAP_us=$'\e[04;38;5;146m' # begin underline

# }}}
