#!/usr/bin/env fish

function pb
    curl -sF "c=@{1:--}" -F p=1 -w "%{redirect_url}" 'https://ptpb.pw/?r=1' -o /dev/stderr | xsel -l /dev/null -b
end
