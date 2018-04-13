function csv
    column -s, -t < $argv | less -#1 -N -S
end
