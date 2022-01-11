#!/usr/bin/env zsh

# ==============================================================================
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zsh/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block, everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
# ==============================================================================

declare -A ZINIT

### Added by Zinit's installer
if [[ ! -f $HOME/.zinit/bin/zinit.zsh ]]; then
  print -P "%F{33}▓▒░ %F{220}Installing %F{33}DHARMA%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
  command mkdir -p "$HOME/.zinit" && command chmod g-rwX "$HOME/.zinit"
  command git clone https://github.com/zdharma-continuum/zinit "$HOME/.zinit/bin" && \
      print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
      print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi

source "$HOME/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit
### End of Zinit's installer chunk

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
# zinit light-mode for \
#     zinit-zsh/z-a-rust \
#     zinit-zsh/z-a-as-monitor \
#     zinit-zsh/z-a-patch-dl \
#     zinit-zsh/z-a-bin-gem-node
### End of Zinit's installer chunk
# ==============================================================================

fpath=(
  /usr/share/zsh/site-functions
  $ZDOTDIR/functions
  # $ZDOTDIR/completions
  "${fpath[@]}"
)

# ==============================================================================
HISTFILE=${ZDOTDIR}/zsh_history
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
HISTORY_IGNORE="(exit|ls|r|open|pwd|q|x *|kill *|s *|cd *)"

setopt NO_HUP                                           # don't kill jobs
setopt NO_CHECK_JOBS
setopt correct                                          # spelling correction for commands
setopt autocd
unsetopt rm_star_silent                                 # ask for confirmation for `rm *' or `rm path/*'
setopt interactivecomments
setopt extended_glob

typeset -gA FAST_HIGHLIGHT_STYLES
FAST_HIGHLIGHT_STYLES[alias]="fg=blue"
FAST_HIGHLIGHT_STYLES[path]="fg=blue"
FAST_HIGHLIGHT_STYLES[path-to-dir]="fg=blue,underline"
FAST_HIGHLIGHT_STYLES[suffix-alias]="fg=blue"
FAST_HIGHLIGHT_STYLES[builtin]="fg=blue"
FAST_HIGHLIGHT_STYLES[function]="fg=blue"
FAST_HIGHLIGHT_STYLES[precommand]="fg=red,bg=default,underline,bold"
FAST_HIGHLIGHT_STYLES[command]="fg=blue"
# FAST_HIGHLIGHT_STYLES[commandseparator]="fg=16"
FAST_HIGHLIGHT_STYLES[comment]="fg=008,bold,italic"
FAST_HIGHLIGHT_STYLES[single-quoted-argument]="fg=yellow"
FAST_HIGHLIGHT_STYLES[double-quoted-argument]="fg=yellow"
FAST_HIGHLIGHT_STYLES[dollar-quoted-argument]="fg=yellow"
FAST_HIGHLIGHT_STYLES[single-hyphen-option]="fg=yellow"
FAST_HIGHLIGHT_STYLES[double-hyphen-option]="fg=yellow"
FAST_HIGHLIGHT_STYLES[variable]="fg=016"
HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND='bg=012,fg=255,bold'
# ==============================================================================

unalias run-help
unalias zplg

# ==============================================================================
# ===  PLUGINS  ===
# {{{

zi ice wait lucid
zi light "zsh-users/zsh-history-substring-search"

zi wait lucid for \
  atinit"ZINIT[COMPINIT_OPTS]=-C; zicompinit; zicdreplay" \
    light-mode zdharma-continuum/fast-syntax-highlighting \
  blockf \
    light-mode zsh-users/zsh-completions \
  compile'{src/*.zsh,src/strategies/*}' atload"!_zsh_autosuggest_start" \
    light-mode zsh-users/zsh-autosuggestions

zi ice lucid wait'[[ -n ${ZLAST_COMMANDS[(r)g*]} ]]'
zi snippet "OMZ::plugins/git/git.plugin.zsh"
zi ice lucid wait'[[ -n ${ZLAST_COMMANDS[(r)g*]} ]]'
zi snippet "OMZ::plugins/git-extras/git-extras.plugin.zsh"
zi ice lucid wait'[[ -n ${ZLAST_COMMANDS[(r)g*]} ]]'
zi light "wfxr/forgit"

zi ice wait'[[ -n ${ZLAST_COMMANDS[(r)cd*]} ]]' lucid pick"init.sh"
zi light "b4b4r07/enhancd"
# zi ice wait lucid
# zi light "changyuheng/zsh-interactive-cd"

# zi ice depth=1
# zi light "jeffreytse/zsh-vi-mode"

# zi ice lucid from"gh-r" as'program' bpick"" pick"def-matcher"
# zi light sei40kr/fast-alias-tips-bin
# zi ice wait"2h" lucid
# zi light sei40kr/zsh-fast-alias-tips

#zi ice wait lucid
#zi light "xPMo/zsh-toggle-command-prefix"

#zi light "willghatch/zsh-cdr"
#zi light "zsh-users/zaw"

zi ice wait"1" lucid nocompletions
zi light "hlissner/zsh-autopair"

#zi ice wait"2" lucid
#zi snippet "OMZ::plugins/ssh-agent/ssh-agent.plugin.zsh"

zi ice lucid wait'[[ -n ${ZLAST_COMMANDS[(r)np*]} ]]'
zi snippet "OMZ::plugins/npm/npm.plugin.zsh"

zi ice lucid wait'[[ -n ${ZLAST_COMMANDS[(r)p*]} ]]' id-as"pnpm-completions" \
  mv"pnpm-completions -> _pnpm" as"completion" nocompile atinit"source _pnpm"
zi snippet "https://raw.githubusercontent.com/SebastienWae/pnpm-completions/main/pnpm.zsh"

if [[ $(type -p fzf) ]] then
   zi ice wait lucid multisrc"{key-bindings,completion}.zsh" pick"" \
     atload"\
     _fzf_compgen_path() { command fd -L -td -tf -tl -H -E \".git\" . \"\$1\" 2> /dev/null }; \
     _fzf_compgen_dir() { command fd -L -td -H -E \".git\" . \"\$1\" 2> /dev/null }"
  zi light "/usr/share/fzf"
fi

zi ice wait"1" lucid
zi snippet "OMZ::plugins/extract/extract.plugin.zsh"
#zi ice wait"2" lucid
#zi snippet "OMZ::plugins/sudo/sudo.plugin.zsh"
#zi ice wait"2" lucid
#zi snippet "OMZ::plugins/fancy-ctrl-z/fancy-ctrl-z.plugin.zsh"
#zi ice wait"2" lucid
#zi snippet "OMZ::plugins/tmux/tmux.plugin.zsh"

#zi ice wait"3" lucid
#zi light "marzocchi/zsh-notify"

# if [[ ! -d ~/.rbenv/plugins ]] then
#   echo "Creating \$(rbenv root)/plugins"
#   mkdir -p ~/.rbenv/plugins
#   if [[ ! -d ~/.rbenv/plugins/ruby-build ]] then
#      echo "Cloning \$(rbenv root)/plugins/ruby-build"
#      git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
#   fi
# fi
# zi ice svn lucid \
#  wait'[[ -n ${ZLAST_COMMANDS[(r)rben*]} ]]' \
#  atload"POWERLEVEL9K_RBENV_PROMPT_ALWAYS_SHOW=true" \
#  unload"![[ ! -e Gemfile || ! -e Rakefile ]]"
# zi snippet "PZT::modules/ruby/"
#
#zi ice wait"3a" lucid wait"[[ -f Gemfile || -f Rakefile ]]" unload"[[ ! -f Gemfile ]]"
#zi snippet "OMZ::plugins/rbenv/rbenv.plugin.zsh"

#zi ice lucid wait \
#  as'command' pick'bin/pyenv' \
#  atload'eval "$(pyenv init - --no-rehash zsh)"; echo "TEST"' \
#  src'completions/pyenv.zsh' nocompile'!'
#zi light pyenv/pyenv
#export PYENV_ROOT="$HOME/.pyenv"

#zi ice lucid wait'[[ -n ${ZLAST_COMMANDS[(r)pyenv]} ]]' \
#  as'command' pick"bin/*" \
#  atload'eval "$(pyenv virtualenv-init - zsh)"'
#zi light pyenv/pyenv-virtualenv

zi ice lucid wait"[[ -f package-lock.json ]]" atload"[[ -f .nvmrc ]] && nvm exec" # wait'[[ -n ${ZLAST_COMMANDS[(r)nv]} ]]'
zi light sei40kr/zsh-lazy-nvm

zi ice wait'[[ -n ${ZLAST_COMMANDS[(r)e*]} ]]' lucid svn #atclone"sed -i '1,13d; 51d; s|\$ZSH/plugins|\$ZINIT[SNIPPETS_DIR]/OMZ::plugins|' emacs.plugin.zsh"
zi snippet "OMZ::plugins/emacs"

#zi ice wait lucid atload"[[ -r ~/.base16_theme ]] || base16_tomorrow-night"
#zi light "chriskempson/base16-shell"

zi ice lucid reset \
  atclone"dircolors -b LS_COLORS > c.zsh; sed -i 's/30/12/g; s/172/11/g; s/196/9/g' c.zsh;" \
  atpull'%atclone' pick"c.zsh" nocompile'!' \
  atload'zstyle ":completion:*:default" list-colors ${(s.:.)LS_COLORS}'
zi light trapd00r/LS_COLORS

#zi ice lucid from"gh-r" as"program" bpick"*linux*" mv"lsd* -> lsd" pick"lsd/lsd"
#zi light "Peltoche/lsd"

#zi ice from"gh-r" as"program" mv"direnv* -> direnv" \
#  atclone"./direnv hook zsh > zhook.zsh" atpull"%atclone" compile"zhook.zsh" src"zhook.zsh"
#zi light direnv/direnv

zi ice wait'[[ -n ${ZLAST_COMMANDS[(r)ch*]} ]]' lucid as"program" mv"*cht.sh -> cht" pick"cht" id-as"cht.sh"
zi snippet "https://cht.sh/:cht.sh"
#zi ice wait"2" lucid id-as"tldr" as"program" pick"tldr"
#zi snippet "https://raw.githubusercontent.com/raylee/tldr/master/tldr"

zi ice wait'[[ -n ${ZLAST_COMMANDS[(r)ps*]} ]]' lucid as"program" mv"ps_mem.py -> psmem" pick"psmem"
zi light "pixelb/ps_mem"

zi ice lucid from"gh-r" as"program"
zi light "so-fancy/diff-so-fancy"

#zi ice pick"fasd" as"program"
#zi snippet "https://raw.githubusercontent.com/clvv/fasd/master/fasd"
#zi snippet "OMZ::plugins/fasd/fasd.plugin.zsh"

# zi ice lucid as"program" pick"pfetch"
# zi light "dylanaraps/pfetch"

# zi ice lucid from"gh-r" as"program" bpick"*linux*"
# zi light "imsnif/bandwhich"

#zi ice lucid from"gh-r" as"program" bpick"*linux*" pick"bat-v0.13.0-x86_64-unknown-linux-gnu/bat"
#zi light "sharkdp/bat"

# zi ice lucid from"gh-r" as"program" bpick"*linux*"
# zi light "casey/intermodal"

# zi ice lucid from"gh-r" as"program" bpick"*linux-x86_64*" mv"shell/exercism_completion.zsh -> _exercism"
# zi light "exercism/cli"

#zi ice wait"2" lucid as"program" pick"build/release/peaclock" atclone"./build.sh"
#zi light "octobanana/peaclock"

zi ice wait'[[ -n ${ZLAST_COMMANDS[(r)her*]} ]]' lucid as"program" pick"heroku"
zi light "$HOME/.local/bin/heroku/bin"
zi ice wait'[[ -n ${ZLAST_COMMANDS[(r)her*]} ]]' lucid #cloneonly
zi snippet "OMZ::plugins/heroku/heroku.plugin.zsh"

#zi ice as"program" pick"bin/sml"
#zi snippet "/home/mustaqim/.local/bin/sml/bin/sml"

# zi ice lucid from"gh-r" as"program"
# zi light "pinterest/ktlint"

# zi ice lucid blockf
# zi light "ziglang/shell-completions"

# }}}

zi creinstall -Q $ZDOTDIR/completions

# === THEME ===
# {{{
#PS1="%F{green}%B$❯%b%f "
zi ice depth'1' lucid atinit'[[ ! -f ~/.zsh/.p10k-lean.zsh ]] || source ~/.zsh/.p10k-lean.zsh' nocd atload"!_p9k_do_nothing _p9k_precmd"
zi light romkatv/powerlevel10k
# }}}


# === FUNCTIONS ===
# {{{
if [ -n "$INSIDE_VIFM" ]; then
    RANGER_LEVEL=""
    unset INSIDE_VIFM
fi

# Compile to decrease startup speed (only if $1 is older than 4 hours)
_zcompare() {
  # - '#q' is an explicit glob qualifier that makes globbing work within zsh's [[ ]] construct.
  # - 'N' makes the glob pattern evaluate to nothing when it doesn't match (rather than throw a globbing error)
  # - '.' matches "regular files"
  # - 'mh+4' matches files (or directories or whatever) that are older than 4 hours.
  setopt extendedglob local_options
  if [[ -n "${1}"(#qN.mh+4) && (! -s "${1}.zwc" || "$1" -nt "${1}.zwc") ]]; then
    ZINIT[COMPINIT_OPTS]=-C; zicompinit; zicdreplay
    zcompile ${1}
  fi
}
_zcomp() {
  zshrc="${ZDOTDIR}/.zshrc"
  zcompdump="${ZDOTDIR}/.zcompdump"
  p10k="${ZDOTDIR}/.p10k-lean.zsh"

  _zcompare "$zshrc"
  _zcompare "$zcompdump"
  _zcompare "$p10k"

  # for file in /home/mustaqim/.zsh/functions/**/*(.); _zcompare "$file"

}

zshaddhistory() { whence ${${(z)1}[1]} >| /dev/null || return 1 }

man() {
 if [ -n "$TMUX" ]; then
 tmux split-window -h -p 40 \
   /bin/man "$@"
   # emacsclient -nw -e "(let ((Man-notify-method 'bully)) (man \"$1\") (evil-local-set-key 'normal \"q\" (lambda () (interactive) (+workspace:delete) (delete-frame))))"
 else
   /bin/man "$@"
   # emacsclient -nw -e "(let ((Man-notify-method 'bully)) (man \"$1\"))"
 fi
}

function gitignore() { curl -sLw "\n" https://www.gitignore.io/api/"$@" ;}

# # Ctrl-w - delete a full WORD (including colon, dot, comma, quotes...)
# my-backward-kill-word () {
#   # Add colon, comma, single/double quotes to word chars
#   local WORDCHARS='*?_-.[]~=/&;!#$%^(){}<>:,"'"'"
#   zle -f kill # Append to the kill ring on subsequent kills.
#   zle backward-kill-word
# }
# zle -N my-backward-kill-word
# bindkey '^w' my-backward-kill-word

fzf-open-file-or-dir() {
  local cmd="_fzf_compgen_path -calways $(pwd)"
  local out=$(eval $cmd | fzf-tmux --exit-0)

  if [ -f "$out" ]; then
    /bin/emacs -nw "$out" </dev/tty
  elif [ -d "$out" ]; then
    cd "$out"
    zle accept-line
  fi
}

# }}}


# === BINDINGS ===
# {{{
zle     -N        fzf-open-file-or-dir
bindkey '^O'      fzf-open-file-or-dir

bindkey '^[[A'    history-substring-search-up
bindkey '^P'      history-substring-search-up
bindkey '^[[B'    history-substring-search-down
bindkey '^N'      history-substring-search-down
bindkey '^[[1;5C' vi-forward-word
bindkey '^[[1;5D' vi-backward-word
bindkey '^F'      vi-forward-word
bindkey '^B'      emacs-backward-word
bindkey '^A'      beginning-of-line
# bindkey '^E'      end-of-line
# bindkey '^O'      push-line-or-edit
bindkey '^[[P'    delete-char
bindkey '^W'      backward-kill-word
bindkey '^[[Z'    reverse-menu-complete

zle -N            autosuggest-accept
bindkey '^[f'     autosuggest-accept

autoload -U       edit-command-line
zle -N            edit-command-line
bindkey '^x^e'    edit-command-line

# }}}

# Fish-like search completions functionality
zmodload zsh/complist
setopt menucomplete
zstyle ':completion:*'               menu select=2 search

zstyle ':completion:*'               matcher-list '' \
       'm:{a-z\-}={A-Z\_}' \
       'r:[^[:alpha:]]||[[:alpha:]]=** r:|=* m:{a-z\-}={A-Z\_}' \
       'r:|?=** m:{a-z\-}={A-Z\_}'

zstyle ':completion:*'               completer _complete _match _approximate
zstyle ':completion:*:match:*'       original only
zstyle ':completion:*:approximate:*' max-errors 1 numeric

zstyle ':completion:*'               group-name ''
zstyle ':completion:*'               list-dirs-first true
zstyle ':completion:*'               auto-description
zstyle ':completion:*'               file-patterns '%p:globbed-files' '*(-/):directories' '*:all-files'

zstyle ':completion:*:manuals'       separate-sections true
zstyle ':completion:*:manuals.*'     insert-sections   true
zstyle ':completion:*:man:*'         menu yes select

zstyle ':completion:*:corrections'   format ' %B%F{green} %d (errors: %e)  %f%b'
zstyle ':completion:*:descriptions'  format ' %F{yellow} %U%d%u  %f'
zstyle ':completion:*:messages'      format ' %B%F{magenta}  %U%d%u  %f%b'
zstyle ':completion:*:warnings'      format ' %B%F{red} %Uno matches found%u %f%b'
# zstyle ':completion:*:default'       list-colors ${(s.:.)LS_COLORS}

zstyle ':completion:*:parameters'    ignored-patterns '_*'

zstyle ':completion:*'               use-cache on
zstyle ':completion:*'               cache-path "$XDG_CACHE_HOME/zsh/.zcompcache"

zmodload zsh/complist
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect 'l' vi-forward-char

# zstyle ':notify:*'                   notifier /bin/notify-send # Only needed for custom scripts
# zstyle ':notify:*'                   error-title "Command failed in #{time_elapsed}s"
# zstyle ':notify:*'                   success-title "Command finished in #{time_elapsed}s"
# zstyle ':notify:*'                   error-icon "/usr/share/emoticons/EmojiOne/1f3f3.png"
# zstyle ':notify:*'                   success-icon "/usr/share/emoticons/EmojiOne/1f389.png"
# zstyle ':notify:*'                   command-complete-timeout 15
# zstyle ':notify:*'                   activate-terminal no

autoload -U select-word-style
select-word-style bash # Delete word at a time

source $ZDOTDIR/aliases

# Load autoload shell functions on demand
autoload -Uz cdl open fzf_log yadm_log_diff mkcd f fz fh fkill fco gfy headphones kd pb scan center_text switch_theme plain push ert-run sqlint magit clip decode
#autoload -Uz cargo cargo-clippy cargo-fmt cargo-miri clippy-driver rls rust-gdb rust-lldb rustc rustdoc rustfmt rustup
autoload zcalc

# generic completions for programs which understand GNU long options(--help)
zicompdef _gnu_generic aomenc ar aria2c bandwhich curl cwebp cjxl direnv docker \
  dunst emacs flask fsck.ext4 fzf gocryptfs hexyl inkscape ktlint light \
  lsd mimeo megadl mkfs.vfat nzbget pamixer pip pip3 pipx psmem pw-cli redshift rofi rustc \
  tlp tlp-stat \
  vue zstd

# for comp ( yadm vifm ) { zicompdef _$comp $comp; }
