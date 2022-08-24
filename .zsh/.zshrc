#!/usr/bin/env zsh

ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
source "${ZINIT_HOME}/zinit.zsh"

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zdharma-continuum/zinit-annex-bin-gem-node
    # zdharma-continuum/zinit-annex-readurl \
    # zdharma-continuum/zinit-annex-patch-dl \
    # zdharma-continuum/zinit-annex-rust
### End of Zinit's installer chunk
# ==============================================================================

fpath=(
  # /usr/share/zsh/site-functions
  $ZDOTDIR/functions
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
HISTORY_IGNORE="(builtin *|exit|ls|r|open|pwd|q|x *|kill *|s *|cd *)"

setopt NO_HUP                                           # don't kill jobs
setopt NO_CHECK_JOBS
setopt correct                                          # spelling correction for commands
setopt autocd
setopt interactivecomments
setopt extended_glob
unsetopt rm_star_silent                                 # ask for confirmation for rm * or rm path/*

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
zle_highlight=('paste:reverse')
# ==============================================================================

# unalias run-help
# unalias zplg

# ==============================================================================
# === PLUGINS ===
# === THEME ===
# zi ice depth'1' lucid atinit'source ~/.zsh/.p10k-lean-8colors.zsh' nocd atload"!_p9k_do_nothing _p9k_precmd"
# zi light romkatv/powerlevel10k
PROMPT=$'\n'"%F{blue}~%f"$'\n'"$ "
zi lucid light-mode from"gh-r" bpick"*linux-gnu.tar.gz" nocompile sbin"starship" \
  atclone"./starship init zsh > init.zsh; zcompile init.zsh; \
  ./starship completions zsh > _starship" atpull"%atclone" for \
  "starship/starship"

zi lucid light-mode wait for \
  atclone'(){local f;cd -q →*;for f (*~*.zwc){zcompile -Uz -- ${f}};}' \
  atpull'%atclone' compile'.*fast*~*.zwc' nocompletions nocd \
  atinit"ZINIT[COMPINIT_OPTS]=-C; zicompinit; zicdreplay" \
    zdharma-continuum/fast-syntax-highlighting \
  atinit"
    bindkey '^[[A' history-substring-search-up
    bindkey '^P'   history-substring-search-up
    bindkey '^[[B' history-substring-search-down
    bindkey '^N'   history-substring-search-down"\
  zsh-users/zsh-history-substring-search \
  blockf atpull'zinit creinstall -q ~/.zsh/completions'\
    zsh-users/zsh-completions \
  compile'{src/*.zsh,src/strategies/*}' atload'!_zsh_autosuggest_start' \
    zsh-users/zsh-autosuggestions

# zi lucid for \
#   larkery/zsh-histdb

zi lucid light-mode wait'[[ -n ${ZLAST_COMMANDS[(r)g*]} ]]' for \
  "OMZ::plugins/git/git.plugin.zsh" \
  "OMZ::plugins/git-extras/git-extras.plugin.zsh" \
  "wfxr/forgit"

zi lucid light-mode wait'[[ -n ${ZLAST_COMMANDS[(r)g*]} ]]' \
 atinit'zstyle ":omz:plugins:ssh-agent" identities GitHub GitLab' for \
 "OMZ::plugins/ssh-agent/ssh-agent.plugin.zsh"

zi lucid light-mode wait'[[ -n ${ZLAST_COMMANDS[(r)c*]} ]]' pick"init.sh" for \
  "b4b4r07/enhancd"

# zi ice depth=1
# zi light "jeffreytse/zsh-vi-mode"

# if [[ $(type -p fzf) ]] then
zi lucid light-mode wait"1" multisrc"{key-bindings,completion}.zsh" atload" \
  _fzf_compgen_path() { command fd -L -td -tf -tl -H -E \".git\" . \"\$1\" 2> /dev/null }; \
  _fzf_compgen_dir() { command fd -L -td -H -E \".git\" . \"\$1\" 2> /dev/null }" for \
  "/usr/share/fzf"
# fi

zi lucid light-mode wait"1" compile"*.zsh" nocompletions for \
  "hlissner/zsh-autopair"

# zi ice wait'[[ -n ${ZLAST_COMMANDS[(r)e*]} ]]' lucid svn
# zi snippet "OMZ::plugins/emacs"

zi lucid light-mode wait"1" \
  atclone"sed -i 's/38;5;30/38;5;4/g; s/38;5;172/38;5;16/g; s/38;5;196/38;5;9/g' LS_COLORS; \
  dircolors -b LS_COLORS > c.zsh" \
  atpull'%atclone' pick"c.zsh" nocompile'!' atload'zstyle ":completion:*:default" list-colors "${(s.:.)LS_COLORS}"' for \
  "trapd00r/LS_COLORS"

# zi light "Aloxaf/fzf-tab"
# zstyle ':completion:*:descriptions' format '[%d]'
# zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls -1 --color=always $realpath'

# zi ice from"gh-r" as"program" mv"direnv* -> direnv" \
#  atclone"./direnv hook zsh > zhook.zsh" atpull"%atclone" compile"zhook.zsh" src"zhook.zsh"
# zi light direnv/direnv

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
# zi ice wait"3a" lucid wait"[[ -f Gemfile || -f Rakefile ]]" unload"[[ ! -f Gemfile ]]"
# zi snippet "OMZ::plugins/rbenv/rbenv.plugin.zsh"

# zi ice lucid wait"[[ -f package-lock.json ]]" atload"[[ -f .nvmrc ]] && nvm exec" # wait'[[ -n ${ZLAST_COMMANDS[(r)nv]} ]]'
# zi light sei40kr/zsh-lazy-nvm

# zi ice lucid wait'[[ -n ${ZLAST_COMMANDS[(r)np*]} ]]'
# zi snippet "OMZ::plugins/npm/npm.plugin.zsh"

zi lucid light-mode wait'[[ -n ${ZLAST_COMMANDS[(r)pn*]} ]]' id-as"pnpm-completions" \
  mv"pnpm-completions -> _pnpm" as"completion" nocompile blockf atinit"source _pnpm" for \
  "https://raw.githubusercontent.com/SebastienWae/pnpm-completions/main/pnpm.zsh"

zi lucid light-mode wait'[[ -n ${ZLAST_COMMANDS[(r)den*]} ]]'\
  from'gh-r' bpick"*linux-gnu*" ver"latest" nocompile sbin'*->deno' for \
  denoland/deno

# zi ice lucid wait \
#  as'command' pick'bin/pyenv' \
#  atload'eval "$(pyenv init - --no-rehash zsh)"; echo "TEST"' \
#  src'completions/pyenv.zsh' nocompile'!'
# zi light pyenv/pyenv
# export PYENV_ROOT="$HOME/.pyenv"

# zi ice lucid wait'[[ -n ${ZLAST_COMMANDS[(r)pyenv]} ]]' \
#  as'command' pick"bin/*" \
#  atload'eval "$(pyenv virtualenv-init - zsh)"'
# zi light pyenv/pyenv-virtualenv

# zi ice wait'[[ -n ${ZLAST_COMMANDS[(r)ch*]} ]]' lucid as"program" mv"*cht.sh -> cht" pick"cht" id-as"cht.sh"
# zi snippet "https://cht.sh/:cht.sh"
# zi ice wait"2" lucid id-as"tldr" as"program" pick"tldr"
# zi snippet "https://raw.githubusercontent.com/raylee/tldr/master/tldr"

zi ice wait'[[ -n ${ZLAST_COMMANDS[(r)ps*]} ]]' lucid as"program" mv"ps_mem.py -> psmem" pick"psmem"
zi light "pixelb/ps_mem"

# zi ice lucid as"program" pick"pfetch"
# zi light "dylanaraps/pfetch"

# zi ice lucid from"gh-r" as"program" bpick"*linux*"
# zi light "casey/intermodal"

# zi ice lucid from"gh-r" as"program" bpick"*linux-x86_64*" mv"shell/exercism_completion.zsh -> _exercism"
# zi light "exercism/cli"

# zi ice wait'[[ -n ${ZLAST_COMMANDS[(r)her*]} ]]' lucid as"program" pick"heroku"
# zi light "$HOME/.local/bin/heroku/bin"
# zi ice wait'[[ -n ${ZLAST_COMMANDS[(r)her*]} ]]' lucid #cloneonly
# zi snippet "OMZ::plugins/heroku/heroku.plugin.zsh"

zi lucid light-mode wait'[[ -n ${ZLAST_COMMANDS[(r)her*]} ]]' extract"!-" id-as"heroku" \
  nocompile sbin'*bin/heroku->heroku' for \
  "https://cli-assets.heroku.com/heroku-linux-x64.tar.gz"
zi ice lucid wait'[[ -n ${ZLAST_COMMANDS[(r)her*]} ]]'
zi snippet "OMZ::plugins/heroku/heroku.plugin.zsh"

# zi ice as"program" pick"bin/sml"
# zi snippet "~/.local/bin/sml/bin/sml"

# zi ice lucid from"gh-r" as"program"
# zi light "pinterest/ktlint"

# zi ice lucid blockf
# zi light "ziglang/shell-completions"

zi lucid light-mode wait'[[ -n ${ZLAST_COMMANDS[(r)rust*]} ]]' \
  from'gh-r' bpick"*linux-gnu.gz" ver"latest" nocompile sbin'*->rust-analyzer' for \
  rust-lang/rust-analyzer

zi lucid light-mode wait'[[ -n ${ZLAST_COMMANDS[(r)tr*]} ]]' \
  from'gh-r' nocompile sbin'*->tree-sitter' for \
  tree-sitter/tree-sitter

# zi light romkatv/zsh-prompt-benchmark


# === FUNCTIONS ===
# if [ -n "$INSIDE_VIFM" ]; then RANGER_LEVEL=""; unset INSIDE_VIFM; fi

# Compile to decrease startup speed (only if $1 is older than 4 hours)
_zcompare() {
  # - '#q' is an explicit glob qualifier that makes globbing work within zsh's [[ ]] construct.
  # - 'N' makes the glob pattern evaluate to nothing when it doesn't match (rather than throw a globbing error)
  # - '.' matches "regular files"
  # - 'mh+4' matches files (or directories or whatever) that are older than 4 hours.
  # setopt extendedglob local_options
  # if [[ -n "${1}"(#qN.mh+4) && (! -s "${1}.zwc" || "$1" -nt "${1}.zwc" ) ]]; then
  if [[ -s ${1} && ( ! -s ${1}.zwc || ${1} -nt ${1}.zwc) ]]; then
    ZINIT[COMPINIT_OPTS]=-C; zicompinit; zicdreplay
    zcompile ${1}
  fi
}
_zcomp() {
  zshrc="${ZDOTDIR}/.zshrc"
  zcompdump="${ZDOTDIR}/.zcompdump"
  zshenv="${ZDOTDIR}/.zshenv"
  zprofile="${ZDOTDIR}/.zprofile"

  _zcompare "$zshrc"
  _zcompare "$zcompdump"
  _zcompare "$zshenv"
  _zcompare "$zprofile"
}
_zcomp
# for file in ~/.zsh/functions/**/*(.); _zcompare "$file"

zshaddhistory() { whence ${${(z)1}[1]} >| /dev/null || return 1 }

# Ctrl-w - delete a full WORD (including colon, dot, comma, quotes...)
# my-backward-kill-word () {
#   # Add colon, comma, single/double quotes to word chars
#   local WORDCHARS='*?_-.[]~=/&;!#$%^(){}<>:,"'"'"
#   zle -f kill # Append to the kill ring on subsequent kills.
#   zle backward-kill-word
# zle -N my-backward-kill-word
# bindkey '^w' my-backward-kill-word

# fzf-open-file-or-dir() {
#   local cmd="_fzf_compgen_path -calways $(pwd)"
#   local out=$(eval $cmd | fzf-tmux --exit-0)

#   if [ -f "$out" ]; then
#     /bin/emacs -nw "$out" </dev/tty
#   elif [ -d "$out" ]; then
#     cd "$out"
#     zle accept-line
#   fi
# }


# === BINDINGS ===
# zle     -N        fzf-open-file-or-dir
# bindkey '^O'      fzf-open-file-or-dir

# bindkey '^[[A'    history-substring-search-up
# bindkey '^P'      history-substring-search-up
# bindkey '^[[B'    history-substring-search-down
# bindkey '^N'      history-substring-search-down
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

# zle -N            autosuggest-accept
# bindkey '^F'      autosuggest-accept

# autoload -U       edit-command-line
# zle -N            edit-command-line
# bindkey '^x^e'    edit-command-line

# Fish-like search completions functionality
zmodload zsh/complist
setopt menucomplete
zstyle ':completion:*'               menu select=2 search

bindkey -M menuselect '/'            history-incremental-search-forward
bindkey -M menuselect '?'            history-incremental-search-backward
bindkey -M menuselect '^B'           vi-backward-char
bindkey -M menuselect '^P'           vi-up-line-or-history
bindkey -M menuselect '^N'           vi-down-line-or-history
bindkey -M menuselect '^F'           vi-forward-char

zstyle ':completion:*'               matcher-list '' \
       'm:{a-z\-}={A-Z\_}' \
       'r:[^[:alpha:]]||[[:alpha:]]=** r:|=* m:{a-z\-}={A-Z\_}' \
       'r:|?=** m:{a-z\-}={A-Z\_}'

zstyle ':completion:*'               completer _complete _match _approximate
zstyle ':completion:*:match:*'       original only
zstyle ':completion:*:approximate:*' max-errors 1 numeric

zstyle '*:matches'                   group 'yes'
zstyle ':completion:*'               group-name ''
# zstyle ':completion:*:*:-command-:*' group-order builtins functions aliases commands
zstyle ':completion:*'               group-order files directories

zstyle ':completion:*'               list-dirs-first true
zstyle ':completion:*'               auto-description
zstyle ':completion:*'               file-patterns '%p:globbed-files' '*(-/):directories' '*:all-files'

zstyle ':completion:*:manuals'       separate-sections true
zstyle ':completion:*:manuals.(^1*)' insert-sections   true

zstyle ':completion:*:corrections'   format '%F{green}  %d (errors: %e)  %f'
zstyle ':completion:*:descriptions'  format '%F{blue}  %d  %f'
zstyle ':completion:*:messages'      format '%B%F{magenta}  %U%d%u  %f%b'
zstyle ':completion:*:warnings'      format '%B%F{red} %Uno matches found%u %f%b'
# zstyle ':completion:*:default'       list-colors ${(s.:.)LS_COLORS}

zstyle ':completion:*:parameters'    ignored-patterns '_*'

zstyle ':completion:*'               use-cache on
zstyle ':completion:*'               cache-path "$XDG_CACHE_HOME/zsh/zcompcache"

autoload -U select-word-style
select-word-style bash # Delete a word at a time

# Load autoload shell functions on demand
autoload -Uz decode dl fz fzf_log gitignore kd man magit mkcd plain push switch_theme yadm_log_diff
autoload zcalc

# generic completions for programs which understand GNU long options(--help)
zicompdef _gnu_generic aomenc ar aria2c bandwhich curl cwebp cjxl darkhttpd direnv docker \
  dunst emacs feh ffmpeg ffprobe flask fsck.ext4 fzf gocryptfs hexyl highlight histdb inkscape ktlint light lighttpd \
  lsd mimeo megadl mkfs.vfat nzbget notify-send pamixer pip pip3 pipx psmem pw-cli rofi rustc \
  tlmgr tlp tlp-stat \
  vue zstd

# zi creinstall -Q $ZDOTDIR/completions

# for comp ( yadm vifm ) { zicompdef _$comp $comp; }

