function b
    # `b` to open local git branches in fzf sorted by most recent. Could add --all to script to show remote.
    # enter to open
    # ctrl-d to delete
    git branch --sort=-committerdate | fzf \
        --bind 'ctrl-d:execute(git branch -D (echo {} | tr -d "[:space:][*]"))+reload(git branch --sort=-committerdate)' \
    # enter to checkout
    | read -l branchname; and git checkout (echo $branchname | tr -d "[:space:][*]")
end
