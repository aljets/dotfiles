# Ported to fish from  https://gist.github.com/junegunn/8b572b8d4b5eddd8b85e5f4d40f17236

function is_in_git_repo
    git rev-parse HEAD > /dev/null 2>&1
end

function fzf-down
  fzf --height 50% --min-height 20 --border --bind ctrl-/:toggle-preview $argv
end

function fzf-side
  fzf --height 95% --min-height 20 --border --bind ctrl-/:toggle-preview --preview-window up,85% $argv
end

function _git_f
  # git files
  is_in_git_repo || return
  git -c color.status=always status --short |
  fzf-down -m --ansi --nth 2..,.. \
    --preview 'git diff --color=always -- {-1} | sed 1,4d; cat {-1}' |
  cut -c4- | sed 's/.* -> //'
end

function _git_b
  # git branches
  is_in_git_repo || return
  git branch -a --color=always | grep -v '/HEAD\s' | sort |
  fzf-down --ansi --multi --tac --preview-window right:70% \
    --preview 'git log --oneline --graph --date=short --color=always --pretty="format:%C(auto)%cd %h%d %s" (echo {} | sed s/^..// | cut -d" " -f1)' |
  sed 's/^..//' | cut -d' ' -f1 |
  sed 's#^remotes/##'
end

function _git_t
  # git tags
  is_in_git_repo || return
  git tag --sort -version:refname |
  fzf-down --multi --preview-window right:70% \
    --preview 'git show --color=always {}'
end

function _git_l
  # git logs
  is_in_git_repo || return
  git log --date=short --format="%C(green)%C(bold)%cd %C(auto)%h%d %s (%an)" --graph --color=always |
  fzf-down --ansi --no-sort --reverse --multi --bind 'ctrl-s:toggle-sort' \
    --header 'Press CTRL-S to toggle sort' \
    --preview 'echo {} | grep -o "[a-f0-9]\{7,\}" | xargs git show --color=always' |
  grep -o "[a-f0-9]\{7,\}"
end

function _git_s
  # git stash
  is_in_git_repo || return
  git stash list | fzf-side --reverse -d: --preview 'git stash show --color=always {1}' |
  cut -d: -f1
end

function g
    if [ -z "$argv" ]
        echo 'files
branches
tags
logs
stash' | fzf | cut -c1 | read -l feature; and _git_$feature
        return
    end
    _git_$argv
end
