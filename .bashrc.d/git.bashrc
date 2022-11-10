alias gitl="git log --oneline --decorate --graph"
alias gitsrp="git stash; git rebase; git stash pop"
alias gfasd="git fetch && git switch develop"
alias gfasm="git fetch && git switch main"
alias gitlast='for k in $(git branch|perl -pe s/^..//);do echo -e $(git show --pretty=format:"%Cgreen%ci %Cblue%cr%Creset" $k|head -n 1)\\t$k;done|sort -r'
alias git-shame='git-branches-by-commit-date.sh'

# Open current branch in Github
github-open () {
  REMOTE=$(git config --get remote.origin.url)
  REPO=${REMOTE#*:}
  REPO=${REPO%.*}
  BRANCH=$(git rev-parse --abbrev-ref HEAD)
  bash_open https://github.com/"$REPO"
}
