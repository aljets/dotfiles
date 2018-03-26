function fish_prompt
    echo -n (prompt_pwd)
    if test -d .hg
        echo -n '['(cat .hg/branch)']'
    end
    if set branch (git rev-parse --abbrev-ref HEAD 2> /dev/null)
        echo -n [(set_color bryellow)$branch(set_color normal)]
    end
    echo -n '$ '
    if set -q VIRTUAL_ENV
        echo -n -s (set_color -b blue white) "(" (basename "$VIRTUAL_ENV") ")" (set_color normal) " "
    end
end
