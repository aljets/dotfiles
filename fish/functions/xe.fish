function xe
    set -l tmpfile (mktemp)
    eval $EDITOR $tmpfile
    fish -c (cat $tmpfile)  # or fish $tmpfile, or eval (cat $tmpfile), or commandline -r -- (cat $tmpfile) if don't want to execute
    rm $tmpfile
end
