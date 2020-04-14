#!/usr/bin/env fish

function man
	/bin/man $argv | nvim -c "set ft=man" -
    #emacsclient -nc -e '(man "'$argv[1]'")'
end
