#!/bin/fish

# Start X at login
#if status is-login
#    if test -z "$DISPLAY" -a $XDG_VTNR = 1
#        exec startx -- -keeptty
#    end
#end

# Start tmux
#if status is-interactive
#and not set -q TMUX
#    exec tmux -2
#end


# =+=+=+=+= ENV =+=+=+=
set -g XDG_CONFIG_HOME $HOME/.config
set -g DESKTOP_SESSION KDE
set -g XDG_CURRENT_DESKTOP KDE
set -gx GPG_TTY (tty)
set -g QT_QPA_PLATFORMTHEME "qt5ct"
set -g fish_greeting
#set -g SXHKD_SHELL /usr/bin/sh
set -gx EDITOR "/bin/emacsclient -nw"
set -gx MANPATH /usr/share/man:/usr/local/share/man
set -gx MANPAGER 'nvim -c "set ft=man" -'
#set -gx SSH_ASKPASS /usr/bin/ksshaskpass
set -gx FZF_DEFAULT_COMMAND "rg --files --no-ignore --hidden --follow -g '!{.git,node_modules}/*'"
set -gx RIPGREP_CONFIG_PATH $HOME/.config/ripgrep/rgrc
set -gx _JAVA_AWT_WM_NONREPARENTING 1
set -gx _JAVA_OPTIONS '-Dswing.defaultlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel -Dswing.aatext=true'
set -gx JAVA_FONTS /usr/share/fonts/TTF
set -gx GNUPGHOME $HOME/.config/gnupg
set -gx LESS SRX
#set -gx GTK_THEME Fantome
#set -U fish_key_bindings fish_vi_key_bindings


# =+=+=+=+= COMPLETE =+=+=+=
complete -c cht -xa '(curl -s cheat.sh/:list)'
complete -c xbps-install -a "(xbps-query -Rs '' | cut -f2 -d' ')"

# =+=+=+=+= PLUGINS =+=+=+=
set -g fisher_path $XDG_CONFIG_HOME/fish/fisher

set fish_function_path $fish_function_path $fisher_path/functions
set fish_complete_path $fish_complete_path $fisher_path/completions

for file in $fisher_path/conf.d/*.fish
    builtin source $file 2> /dev/null
end

if not functions -q fisher
    set -q XDG_CONFIG_HOME; or set XDG_CONFIG_HOME ~/.config
    curl https://git.io/fisher --create-dirs -sLo $XDG_CONFIG_HOME/fish/functions/fisher.fish
    fish -c fisher
end


# =+=+=+=+= THEME =+=+=+=
set pure_symbol_prompt "~>"
set pure_symbol_git_down_arrow "⇣"
set pure_symbol_git_up_arrow "⇡"
set pure_symbol_git_dirty "*"
set pure_symbol_horizontal_bar "_"

# Change the colors
set pure_color_blue (set_color "61afef")
set pure_color_cyan (set_color "56b6c2")
set pure_color_gray (set_color "6c6c6c")
set pure_color_green (set_color "98c379")
set pure_color_normal (set_color "000000")
set pure_color_red (set_color "e06c75")
set pure_color_yellow (set_color "d19a66")

# Change colors for username and host in SSH
set pure_username_color $pure_color_yellow
set pure_host_color $pure_color_green
set pure_root_color $pure_color_red

# Change where the username and host is displayed
# 0 - end of prompt, default
# 1 - start of prompt
# Any other value defaults to the default behaviour
#set pure_user_host_location 1

# Show exit code of last command as a separate prompt character.
# As described here: https://github.com/sindresorhus/pure/wiki#show-exit-code-of-last-command-as-a-separate-prompt-character
# 0 - single prompt character, default
# 1 - separate prompt character
# Any other value defaults to the default behaviour
#set pure_separate_prompt_on_error 1

# Max execution time of a process before its run time is shown when it exits
set pure_command_max_exec_time 5


# =+=+=+=+= PATHS =+=+=+=
#set -gx CCACHE /usr/lib/ccache/bin/
#set -gx CARGO_PATH $HOME/.cargo/bin
#set -gx GOPATH $HOME/code/go
#set -gx GEM_ROOT ~/.gem/ruby/2.5.0/bin
#set -gx NODEPATH $HOME/node_modules/.bin
set -gx SCRIPTS $HOME/.local/bin/scripts

set -gx PATH $SCRIPTS $PATH

kitty + complete setup fish | source
