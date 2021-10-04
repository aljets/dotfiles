function b
    # `b` to open local git branches in fzf sorted by most recent. Could add --all to script to show remote.
    # enter to open
    # ctrl-d to delete
    git branch --sort=-committerdate | fzf \
        --bind 'ctrl-d:execute-silent(git branch -D (echo {} | tr -d "[:space:][*]"))+reload(git branch --sort=-committerdate)' \
        --bind 'ctrl-k:up,ctrl-j:down' \
        --preview 'git log --stat --oneline --graph --date=short --color=always --pretty="format:%C(auto)%cd %h%d %s" (echo {} | sed s/^..// | cut -d" " -f1)' \
        --preview-window right:85% \
    # enter to checkout
    | read -l branchname; and git checkout (echo $branchname | tr -d "[:space:][*]")
end
