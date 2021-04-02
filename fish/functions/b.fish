function b
    git checkout (git branch --all --sort=-committerdate | fzf | tr -d '[:space:][*]')
end
