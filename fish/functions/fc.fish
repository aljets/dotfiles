function fc
    set -l tmpfile (mktemp)
    echo $history[1] >> $tmpfile
    eval $EDITOR $tmpfile
    commandline -r -- (cat $tmpfile)
    commandline -f execute
    rm $tmpfile
end
