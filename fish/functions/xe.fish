function xe
    set -l tmpfile (mktemp)
    eval $EDITOR $tmpfile
    commandline -r -- (cat $tmpfile)
    commandline -f execute
    rm $tmpfile
end
