function ls
	/usr/bin/exa -bh --group-directories-first --sort name --git -G -F $argv
end

function lst
	exa -T
end
