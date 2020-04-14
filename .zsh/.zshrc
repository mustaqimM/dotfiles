#!/usr/bin/env zsh

if [ ! -S ~/.ssh/ssh_auth_sock ]; then
  eval `ssh-agent`
  ln -sf "$SSH_AUTH_SOCK" ~/.ssh/ssh_auth_sock
fi
export SSH_AUTH_SOCK=~/.ssh/ssh_auth_sock
#ssh-add -l > /dev/null || ssh-add
#ssh-add -q $HOME/.ssh/GitLab > /dev/null || ssh-add
#ssh-add -q $HOME/.ssh/GitHub > /dev/null || ssh-add

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zsh/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block, everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi


declare -A ZINIT
### Added by Zinit's installer
if [[ ! -f $HOME/.zinit/bin/zinit.zsh ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing DHARMA Initiative Plugin Manager (zdharma/zinit)…%f"
    command mkdir -p "$HOME/.zinit" && command chmod g-rwX "$HOME/.zinit"
    command git clone https://github.com/zdharma/zinit "$HOME/.zinit/bin" && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
        print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi
source "$HOME/.zinit/bin/zinit.zsh"

autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zinit-zsh/z-a-patch-dl \
    zinit-zsh/z-a-as-monitor \
    zinit-zsh/z-a-bin-gem-node
### End of Zinit's installer chunk


fpath=(
  $ZDOTDIR/functions
  $ZDOTDIR/completions
  #$HOME/.cargo/bin
  $HOME/.local/bin/scripts
  "${fpath[@]}"
)


HISTFILE=~/.zsh/zsh_history
HISTSIZE=100000
SAVEHIST=100000
HISTORY_SUBSTRING_SEARCH_ENSURE_UNIQUE=1                # all search results returned will be unique
setopt incappendhistory                                 # add commmand to history as soon as it's entered
setopt extendedhistory                                  # save command timestamp
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_SAVE_NO_DUPS                                # don't write duplicate entries in the history file
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_SPACE                                # prefix commands you don't want stored with a space
HISTORY_IGNORE="(exit|ls|r|open|pwd|q|x *|kill *|s *)"

setopt NO_HUP                                           # don't kill jobs
setopt NO_CHECK_JOBS
setopt correct                                          # spelling correction for commands
setopt autocd
unsetopt rm_star_silent                                 # ask for confirmation for `rm *' or `rm path/*'
setopt interactivecomments
setopt extended_glob

typeset -gA FAST_HIGHLIGHT_STYLES
FAST_HIGHLIGHT_STYLES[alias]="fg=012"
FAST_HIGHLIGHT_STYLES[path]="fg=blue"
FAST_HIGHLIGHT_STYLES[path-to-dir]="fg=blue,underline"
FAST_HIGHLIGHT_STYLES[suffix-alias]="fg=012"
FAST_HIGHLIGHT_STYLES[builtin]="fg=012"
FAST_HIGHLIGHT_STYLES[function]="fg=012"
FAST_HIGHLIGHT_STYLES[precommand]="fg=red,bg=black,underline,bold"
FAST_HIGHLIGHT_STYLES[command]="fg=012"
FAST_HIGHLIGHT_STYLES[commandseparator]="fg=012"
FAST_HIGHLIGHT_STYLES[comment]="fg=011,bold,italic"
FAST_HIGHLIGHT_STYLES[single-quoted-argument]="fg=011"
FAST_HIGHLIGHT_STYLES[double-quoted-argument]="fg=011"
FAST_HIGHLIGHT_STYLES[dollar-quoted-argument]="fg=011"
FAST_HIGHLIGHT_STYLES[single-hyphen-option]="fg=yellow"
FAST_HIGHLIGHT_STYLES[double-hyphen-option]="fg=215"
#export DEFAULT_LS_COLORS="no=00:fi=00:di=01;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:mi=01;05;37;41:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=34;42:st=37;44:ex=01;32:*.tar=01;31:*.tgz=01;31:*.svgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.lzma=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.dz=01;31:*.gz=01;31:*.bz2=01;31:*.tbz2=01;31:*.bz=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.rar=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.svg=01;35:*.aac=00;36:*.au=00;36:*.flac=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:"

unalias run-help
unalias zplg

# }}}


#===  PLUGINS  ==={{{

zpl ice wait"0a" lucid \
  atload"HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND="bg=blue,fg=232,bold""
zpl light "zsh-users/zsh-history-substring-search"

zpl ice wait"0b" lucid compile'{src/*.zsh,src/strategies/*}' atload"!_zsh_autosuggest_start; "
zpl light "zsh-users/zsh-autosuggestions"

zpl ice wait lucid atload"zicompinit; zicdreplay" blockf for \
zpl light-mode "zsh-users/zsh-completions"
#zpl snippet "OMZ::lib/completion.zsh"

zpl ice wait lucid atinit"_zcomp; zpcdreplay"
zpl light "zdharma/fast-syntax-highlighting"

zpl ice lucid wait'[[ -n ${ZLAST_COMMANDS[(r)g*]} ]]'
zpl snippet "OMZ::plugins/git/git.plugin.zsh"
zpl ice lucid wait'[[ -n ${ZLAST_COMMANDS[(r)g*]} ]]'
zpl snippet "OMZ::plugins/git-extras/git-extras.plugin.zsh"
zpl ice lucid wait'[[ -n ${ZLAST_COMMANDS[(r)g*]} ]]'
zpl light "wfxr/forgit"

zpl ice wait lucid pick"init.sh" #atpull"git checkout 718bd31"
zpl light "b4b4r07/enhancd"
zpl ice wait"2g" lucid
zpl light "changyuheng/zsh-interactive-cd"

zpl ice lucid from"gh-r" as'program' bpick"*linux*" pick"def-matcher"
zpl light sei40kr/fast-alias-tips-bin
zpl ice wait"2h" lucid
zpl light sei40kr/zsh-fast-alias-tips

#zpl ice wait lucid
#zpl light "xPMo/zsh-toggle-command-prefix"

#zpl light "willghatch/zsh-cdr"
#zpl light "zsh-users/zaw"

zpl ice wait"2" lucid nocompletions
zpl light "hlissner/zsh-autopair"

#zpl ice wait"2" lucid
#zpl snippet "OMZ::plugins/ssh-agent/ssh-agent.plugin.zsh"

zpl ice lucid wait'[[ -n ${ZLAST_COMMANDS[(r)np*]} ]]'
zpl snippet "OMZ::plugins/npm/npm.plugin.zsh"

zpl ice wait lucid from"gh-r" as"program" \
  atload"_fzf_compgen_path() { fd --type f --hidden --follow --exclude ".git" . "$1" }; \
         _fzf_compgen_dir() { fd --type d --hidden --follow --exclude ".git" . "$1" }"
zpl light junegunn/fzf-bin
if [[ $(type -p fzf) ]] then
  zpl ice wait lucid multisrc"shell/{key-bindings,completion}.zsh" pick""
  zpl light "junegunn/fzf"
fi

zpl ice wait lucid id-as"base16-fzf" atclone"sleep 2; sed -i 's|1d1f21|17191a|;27i\  --ansi \n  --reverse' base16-fzf" atpull"%atclone"
zpl snippet "https://raw.githubusercontent.com/nicodebo/base16-fzf/master/bash/base16-tomorrow-night.config"


zpl ice wait"2" lucid
zpl snippet "OMZ::plugins/extract/extract.plugin.zsh"
#zpl ice wait"2" lucid
#zpl snippet "OMZ::plugins/sudo/sudo.plugin.zsh"
zpl ice wait"2" lucid
zpl snippet "OMZ::plugins/fancy-ctrl-z/fancy-ctrl-z.plugin.zsh"
#zpl ice wait"2" lucid
#zpl snippet "OMZ::plugins/tmux/tmux.plugin.zsh"

#zpl ice wait"3" lucid
#zpl light "marzocchi/zsh-notify"

#if [[ ! -d ~/.rbenv/plugins ]] then
#   echo "Creating \$(rbenv root)/plugins"
#   mkdir -p ~/.rbenv/plugins
#   if [[ ! -d ~/.rbenv/plugins/ruby-build ]] then
#      echo "Cloning \$(rbenv root)/plugins/ruby-build"
#      git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
#   fi
#fi
#zpl ice svn lucid \
#  wait'[[ -n ${ZLAST_COMMANDS[(r)rben*]} ]]' \
#  atload"POWERLEVEL9K_RBENV_PROMPT_ALWAYS_SHOW=true" \
#  unload"![[ ! -e Gemfile || ! -e Rakefile ]]"
#zpl snippet "PZT::modules/ruby/"
#zpl ice wait"3a" lucid wait"[[ -f Gemfile || -f Rakefile ]]" unload"[[ ! -f Gemfile ]]"
#zpl snippet "OMZ::plugins/rbenv/rbenv.plugin.zsh"

#zpl ice lucid wait \
#  as'command' pick'bin/pyenv' \
#  atload'eval "$(pyenv init - --no-rehash zsh)"; echo "TEST"' \
#  src'completions/pyenv.zsh' nocompile'!'
#zpl light pyenv/pyenv
#export PYENV_ROOT="$HOME/.pyenv"

#zpl ice lucid wait'[[ -n ${ZLAST_COMMANDS[(r)pyenv]} ]]' \
#  as'command' pick"bin/*" \
#  atload'eval "$(pyenv virtualenv-init - zsh)"'
#zpl light pyenv/pyenv-virtualenv

zpl ice from"gh-r" as"program" mv"direnv* -> direnv" \
  atclone"./direnv hook zsh > zhook.zsh" atpull"%atclone" compile"zhook.zsh" src"zhook.zsh"
zpl light direnv/direnv

zpl ice wait"3b" lucid mv"*cht.sh -> cht" pick"cht" as"program" id-as"cht.sh"
zpl snippet "https://cht.sh/:cht.sh"
#zpl ice wait"2" lucid id-as"tldr" as"program" pick"tldr"
#zpl snippet "https://raw.githubusercontent.com/raylee/tldr/master/tldr"

zpl ice lucid mv"ps_mem.py -> psmem" pick"psmem" as"program"
zpl light "pixelb/ps_mem"

zpl ice wait"3d" lucid as"program" pick"bin/git-dsf"
zpl light "zdharma/zsh-diff-so-fancy"

#zpl ice wait lucid atload'eval "$(lua /home/mustaqim/.zinit/plugins/skywind3000---z.lua/z.lua --init zsh enhanced once fzf)"'
#zpl light "skywind3000/z.lua"

zpl ice svn atclone"sed -i '1,13d; 51d; s|\$ZSH/plugins|\$ZINIT[SNIPPETS_DIR]/OMZ::plugins|' emacs.plugin.zsh"
zpl snippet "OMZ::plugins/emacs"

#zpl ice pick"fasd" as"program"
#zpl snippet "https://raw.githubusercontent.com/clvv/fasd/master/fasd"
#zpl snippet "OMZ::plugins/fasd/fasd.plugin.zsh"

#zpl ice wait lucid atload"[[ -r ~/.base16_theme ]] || base16_tomorrow-night"
#zpl light "chriskempson/base16-shell"

zpl ice lucid reset \
  atclone"dircolors -b LS_COLORS > c.zsh; sed -i 's/30/12/g; s/172/11/g; s/196/9/g' c.zsh;" \
  atpull'%atclone' pick"c.zsh" nocompile'!' \
  atload'zstyle ":completion:*:default" list-colors ${(s.:.)LS_COLORS}'
zpl light trapd00r/LS_COLORS

zpl ice lucid from"gh-r" as"program" bpick"*linux*" mv"lsd* -> lsd" pick"lsd/lsd"
zpl light "Peltoche/lsd"

zpl ice lucid pick"pfetch" as"program"
zpl light "dylanaraps/pfetch"

zpl ice lucid from"gh-r" as"program" bpick"joe"
zpl light "karan/joe"

zpl ice lucid from"gh-r" as"program" bpick"*linux*"
zpl light "imsnif/bandwhich"

zpl ice lucid from"gh-r" as"program" bpick"*linux*" pick"bat-v0.13.0-x86_64-unknown-linux-gnu/bat"
zpl light "sharkdp/bat"

# Local plugins
#zpl ice lucid as"program" pick"doom"
#zpl snippet "/home/mustaqim/.emacs.d/bin/doom"

#zpl ice wait"2" lucid as"program" pick"colorblocks"
#zpl snippet /home/mustaqim/.local/bin/scripts/colorblocks

#zpl ice wait"2" lucid as"program" pick"build/release/peaclock" atclone"./build.sh"
#zpl light "octobanana/peaclock"

#zpl ice wait"2" lucid as"program" pick"heroku"
#zpl light "$HOME/.local/bin/heroku/bin"
#zpl ice wait"2" lucid cloneonly
#zpl snippet "OMZ::plugins/heroku/heroku.plugin.zsh"

#zpl ice as"program" pick"bin/sml"
#zpl snippet "/home/mustaqim/.local/bin/sml/bin/sml"

# }}}

# === THEMES === {{{

zpl ice lucid atinit'[[ ! -f ~/.zsh/.p10k.zsh ]] || source ~/.zsh/.p10k.zsh'
zpl light romkatv/powerlevel10k
# }}}


# Compile to decrease startup speed (only if $1 is older than 4 hours)
_zcompare() {
  # - '#q' is an explicit glob qualifier that makes globbing work within zsh's [[ ]] construct.
  # - 'N' makes the glob pattern evaluate to nothing when it doesn't match (rather than throw a globbing error)
  # - '.' matches "regular files"
  # - 'mh+4' matches files (or directories or whatever) that are older than 4 hours.
  setopt extendedglob local_options
  if [[ -n "${1}"(#qN.mh+4) && (! -s "${1}.zwc" || "$1" -nt "${1}.zwc") ]]; then
    ZINIT[COMPINIT_OPTS]=-C; zpcompinit
    zcompile ${1}
  fi
}
_zcomp() {
  zshrc="${ZDOTDIR}/.zshrc"
  zcompdump="${ZDOTDIR}/.zcompdump"
  p10k="${ZDOTDIR}/.p10k.zsh"

  _zcompare "$zshrc"
  _zcompare "$zcompdump"
  _zcompare "$p10k"
}

#case $TERM in (xst*)
#  preexec () { print -Pn "\e]0; $PWD - xst\a" }
#  precmd () { print -Pn "\e]0; %~\a" }
#;;
#esac

zshaddhistory() {
  whence ${${(z)1}[1]} >| /dev/null || return 1 }       # Don't add wrong commands to history

function exists() {
  (( ${+commands[$1]} ))
}

fb() {
    filebot -rename "$@" -non-strict --format "{e} - {t}"
}

#man() {
#  if [ -n "$TMUX" ]; then
#    tmux split-window -h -p 40 /bin/man "$@"
#  else
#    /bin/man "$@"
#  fi
#}

function gitignore() { curl -sLw "\n" https://www.gitignore.io/api/"$@" ;}

# Copy and Paste for `st`
x-kill-region () {
  zle kill-region
  print -rn $CUTBUFFER | xsel -i -b
}
zle -N x-kill-region
x-yank () {
  CUTBUFFER=$(xsel -o -b </dev/null)
  zle yank
}
zle -N x-yank
bindkey -e '^X' x-kill-region
bindkey -e '^V' x-yank

fzf-open-file-or-dir() {
  local cmd="fd -j4 -d5 -tf -td -tl -c=always 2> /dev/null"
  local out=$(eval $cmd | fzf)

  if [ -f "$out" ]; then
    $EDITOR --no-wait "$out" < /dev/tty
  elif [ -d "$out" ]; then
    cd "$out"
    zle reset-prompt
  fi
}
zle     -N        fzf-open-file-or-dir
bindkey '^P'      fzf-open-file-or-dir

bindkey '^[[A'    history-substring-search-up
bindkey '^[[B'    history-substring-search-down
bindkey '^[[1;5C' vi-forward-word
bindkey '^[[1;5D' vi-backward-word
bindkey '^F'      vi-forward-word
bindkey '^B'      emacs-backward-word
bindkey '^A'      beginning-of-line
bindkey '^E'      end-of-line
bindkey '^O'      push-line-or-edit
bindkey '^[[P'    delete-char
#bindkey '^[[1;3D'
#bindkey '^[[1;3C'

zle -N            autosuggest-accept
bindkey '^[f'     autosuggest-accept

autoload -U       edit-command-line
zle -N            edit-command-line
bindkey '^x^e'    edit-command-line

#fm(){lf}; zle -N fm
#bindkey '^[t' fm

# Fish-like search completions functionality
zmodload zsh/complist
setopt menucomplete
zstyle ':completion:*'               menu select=0 search

zstyle ':completion:*'               matcher-list '' \
       'm:{a-z\-}={A-Z\_}' \
       'r:[^[:alpha:]]||[[:alpha:]]=** r:|=* m:{a-z\-}={A-Z\_}' \
       'r:|?=** m:{a-z\-}={A-Z\_}'

zstyle ':completion:*'               completer _complete _match _approximate
zstyle ':completion:*:match:*'       original only
zstyle ':completion:*:approximate:*' max-errors 1 numeric

zstyle ':completion:*'               group-name ''          # Keep directories and files separated
#zstyle ':completion:*'               list-dirs-first true
zstyle ':completion:*'               auto-description
zstyle ':completion:*:manuals'       separate-sections true
zstyle ':completion:*:manuals.*'     insert-sections   true
zstyle ':completion:*:man:*'         menu yes select

zstyle ':completion:*:corrections'   format ' %B%F{green} %d (errors: %e)  %f%b'
zstyle ':completion:*:descriptions'  format ' %F{yellow} %U%d%u  %f'
zstyle ':completion:*:messages'      format ' %B%F{magenta}  %U%d%u  %f%b'
zstyle ':completion:*:warnings'      format ' %B%F{red} %Uno matches found%u %f%b'
#zstyle ':completion:*:default'       list-colors ${(s.:.)LS_COLORS}

zstyle ':completion::complete:*'     use-cache on
zstyle ':completion:*'               cache-path ~/.zsh/cache

#zstyle ':notify:*'                   notifier /bin/notify-send # Only needed for custom scripts
zstyle ':notify:*'                   error-title "Command failed in #{time_elapsed}s"
zstyle ':notify:*'                   success-title "Command finished in #{time_elapsed}s"
zstyle ':notify:*'                   error-icon "/usr/share/emoticons/EmojiOne/1f3f3.png"
zstyle ':notify:*'                   success-icon "/usr/share/emoticons/EmojiOne/1f389.png"
zstyle ':notify:*'                   command-complete-timeout 15
zstyle ':notify:*'                   activate-terminal no

zstyle ':completion:*'               file-patterns '%p:globbed-files' '*(-/):directories' '*:all-files'

autoload -U select-word-style
select-word-style bash

source $ZDOTDIR/aliases
autoload -Uz cdl open fzf_log yadm_log_diff mkcd fz code fh fkill fco gfy plain pb scan center_text
#autoload -Uz cargo cargo-clippy cargo-fmt cargo-miri clippy-driver rls rust-gdb rust-lldb rustc rustdoc rustfmt rustup

# generic completions for programs which understand GNU long options(--help)
zpcompdef _gnu_generic fd bat gocryptfs curl fzf tlp-stat cwebp aomenc pip flask \
  docker-machine docker light rofi cargo rustc emacs tar extract psmem firejail direnv \
  aria2c nzbget pipx sk redshift z kitty wmctrl

zpcompdef _yadm yadm

zpcompinit
zplugin cdreplay -q


# vim:ft=zsh:et:fileencoding=utf-8:ft=conf:foldmethod=marker
