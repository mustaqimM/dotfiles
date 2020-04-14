#!/usr/bin/env fish

complete --exclusive --no-files --command plain -n '__fish_prog_needs_command' --arguments 'show' --description 'Show the plain folder'
complete --exclusive --no-files --command plain -n '__fish_prog_needs_command' --arguments 'hide' --description 'Unmount the plain folder'
complete --exclusive --no-files --command plain -n '__fish_prog_needs_command' --arguments 'move' --description 'Move to Plain folder'

function plain
    if test (count $argv) -lt 1
        gocryptfs -q /home/mustaqim/Library/.cipher /home/mustaqim/Library/.plain
    else
        set option $argv[1]
        switch $option
            case hide
                fusermount -u /home/mustaqim/Library/.plain
            case show
                gocryptfs -q /home/mustaqim/Library/.cipher /home/mustaqim/Library/.plain -o -allow_other
                ranger /home/mustaqim/Library/.plain/ & disown; exit
            case move
                fd . ~/Library/Downloads/.var -E '*.part' -x mv "{}" ~/Library/.plain/
        end
    end
end
