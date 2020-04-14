function gfy
    set URL "https://giant.gfycat.com/"
    if test (count $argv) -lt 2
        set TITLE $argv[1]
        wget "$URL$TITLE.webm"
    else
        echo "Unable to find the file ID."
        exit 1
    end
end    
