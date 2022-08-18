#!/usr/bin/env zsh

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"

export XDG_SESSION_TYPE=wayland
export XDG_CURRENT_DESKTOP=Unity
# KDE_SESSION_VERSION=5
# XDG_SESSION_CLASS=user

export QT_QPA_PLATFORMTHEME=qt5ct
export QT_QPA_PLATFORM=wayland
export GTK_USE_PORTAL=0

# export BROWSER="/opt/firefox/firefox"
export MOZ_ENABLE_WAYLAND=1

export TZ=Africa/Johannesburg

# export LC_ALL=C
export LC_ALL="en_ZA.UTF-8"

export LIBVA_DRIVER_NAME=i965

export EDITOR="/bin/emacsclient -nw"

# export TERM=xterm-256color
# export COLORTERM=truecolor

export FZF_DEFAULT_COMMAND="fd -L . --min-depth 1 -t f -t d -H -c always"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND --max-depth 5"
export FZF_ALT_C_COMMAND="fd -L . --min-depth 1 -t d -c always 2> /dev/null"
export FZF_DEFAULT_OPTS="--layout=reverse --ansi --prompt='› ' --pointer='›' --marker='›'
 --color=bg+:18,fg+:015,spinner:yellow,hl:016:bold,hl+:red,info:yellow,pointer:yellow,marker:green,prompt:blue"
# export FZF_COMPLETION_TRIGGER=''
export ENHANCD_FILTER='fzf'
export ENHANCD_COMPLETION_BEHAVIOR=list
export ZSH_AUTOSUGGEST_USE_ASYNC=true
export ZSH_AUTOSUGGEST_MANUAL_REBIND=1
export ZSH_AUTOSUGGEST_STRATEGY=(history completion)
export ZSH_AUTOSUGGEST_COMPLETION_IGNORE="[[:space:]]*"
# FAST_ALIAS_TIPS_PREFIX="$(tput bold)╭───\n\033[01;33m   \033[01;37m"
# FAST_ALIAS_TIPS_SUFFIX="\n╰───$(tput sgr0)"
export CHTSH_QUERY_OPTIONS="style=algol_nu"
# export ZVM_CURSOR_STYLE_ENABLED=false

export GNUPGHOME=$HOME/.config/gnupg
export GPG_TTY=$(tty)
export MANPAGER='nvim +Man!'
export MANPATH=/usr/share/man:/opt/texlive/2022/texmf-dist/doc/man
export DOCKER_HOST=127.0.0.1:2375
export DOOMDIR="~/.config/doom"
export FEH_SKIP_MAGIC=1

# export JAVA_HOME="/usr/lib/jvm/openjdk"
export JAVA_HOME="/usr/lib/jvm/jbrsdk"
export _JAVA_OPTIONS='-Dswing.defaultlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel
 -Dswing.crossplatformlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel
 -Dawt.useSystemAAFontSettings=on -Dswing.aatext=true'
# export CLASSPATH="/home/mustaqim/Downloads/perimeter/apache-csv.jar:courserajava.jar"
export _JAVA_AWT_WM_NONREPARENTING=1

export PNPM_HOME="$HOME/.local/share/pnpm"

# Less Colors for Man Pages
export LESS_TERMCAP_mb=$'\e[01;31m'       # begin blinking
export LESS_TERMCAP_md=$'\e[01;38;5;74m'  # begin bold
export LESS_TERMCAP_me=$'\e[0m'           # end mode
export LESS_TERMCAP_se=$'\e[0m'           # end standout-mode
export LESS_TERMCAP_so=$'\e[38;5;246m'    # begin standout-mode - info box
export LESS_TERMCAP_ue=$'\e[0m'           # end underline
export LESS_TERMCAP_us=$'\e[04;38;5;146m' # begin underline
export LESS_TERMCAP_so=$'\e[30;44m'       # search result

# export RUST_SRC_PATH="/home/mustaqim/.rustup/toolchains/nightly-x86_64-unknown-linux-gnu/lib/rustlib/src/rust/src"
# export ANDROID_HOME="$HOME/Android/Sdk"

# shellcheck source=/home/mustaqim/.priv-env
# source "$HOME/.priv-env"

typeset -U path
path=(
    $HOME/.cargo/bin
    $HOME/.yarn/bin
    $HOME/.emacs.d/bin
    # $HOME/.local/bin
    # $HOME/.local/bin/sml/bin
    # $HOME/.local/bin/language-servers/kotlin-language-server/bin
    # $HOME/.local/bin/ktlint
    $HOME/.local/bin/scripts
    # $ANDROID_HOME/tools
    # $ANDROID_HOME/platform-tools
    /opt/texlive/2022/bin/x86_64-linux
    $JAVA_HOME/bin
    # $HOME/.deno/bin
    $HOME/.local/share/pnpm
    $path
)
# export PATH

# remove duplicate entries (not required if using the -U array flag)
# for i in $( echo $PATH | tr ":" "\n" | sort | uniq )
# do
#     PATH_SORT="${PATH_SORT}$i:"
# done
# PATH="${PATH_SORT%:}"

# === Aliases ===
alias cat=bat
alias chts='cht --shell'
alias f=vifm
alias firefox=/opt/firefox/firefox
alias gpg=gpg2
alias jackett='~/.local/bin/Jackett/jackett'
# alias ktlint='ktlint --android --color --relative -v'
alias nightly=/opt/firefox/firefox-bin
alias q=exit
alias reload='exec zsh'
alias s='googler --count 7'
alias x=dtrx
alias sudo=doas
alias xargs='xargs ' # Needed for alias subtitution
alias yt=yt-dlp
alias ls='lsd'

alias -s {yml,yaml,toml,md}=$EDITOR

forgit_log=fglo
forgit_diff=fgd
forgit_add=fga
forgit_reset_head=fgrh
forgit_ignore=fgi
forgit_checkout_file=fgcf
forgit_checkout_branch=fgcb
forgit_checkout_tag=fgct
forgit_checkout_commit=fgco
forgit_revert_commit=fgrc
forgit_clean=fgclean
forgit_stash_show=fgss
forgit_cherry_pick=fgcp
forgit_rebase=fgrb
forgit_fixup=fgfu
