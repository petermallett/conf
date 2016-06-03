source ~/.profile
source ~/.bash_private

alias gitinfo="git-info.sh | less"
alias gitl="git log --oneline --decorate --graph"
alias gitsrp="git stash; git rebase; git stash pop"
alias gitlast='for k in $(git branch|perl -pe s/^..//);do echo -e $(git show --pretty=format:"%Cgreen%ci %Cblue%cr%Creset" $k|head -n 1)\\t$k;done|sort -r'
alias git-shame='git-branches-by-commit-date.sh'
alias gitx="open /Applications/GitX.app ."
alias termtitle='name=`hostname` echo -n -e "\033]0;$name\007"'
alias drush-debug='XDEBUG_CONFIG="idekey=PHPSTORM" drush $*'
function drush_vdebug {
  vagrant ssh -c "export XDEBUG_CONFIG=\"idekey=PHPSTORM\"; cd docroot; ./vendor/drush/drush/drush.launcher $*"
}
alias gvimdiff='mvim -d'
eval "$(thefuck --alias)"

export CLICOLOR=1

up () {
  if [ -z $1 ]; then
    cd ..
  elif [ $1 -gt 0 ]; then
    let count=1
    cdstr=".."
    while [ $count -lt $1 ]; do
      cdstr="$cdstr/.."
      let count=count+1
    done
    cd $cdstr
  else
    echo "Argument must be a positive integer."
  fi
  pwd
}

if [ -f `brew --prefix`/etc/bash_completion ]; then
  . `brew --prefix`/etc/bash_completion
fi

GIT_PS1_SHOWSTASHSTATE=true
GIT_PS1_SHOWDIRTYSTATE=true
GIT_PS1_SHOWCOLORHINTS=true
#GIT_PS1_SHOWUNTRACKEDFILES=true
PS1=' [\w \t\[\033[0;32m\]$(__git_ps1 " (%s)")\[\033[0m\]]\n$ '
#PROMPT_COMMAND='__git_ps1 "\w \t" "\n \$ "'

# Load RVM into a shell session *as a function*
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

# Updates PATH for the Google Cloud SDK.
source '/Users/petermallett/workspace/google-cloud-sdk/path.bash.inc'
# Enable bash completion for gcloud.
source '/Users/petermallett/workspace/google-cloud-sdk/completion.bash.inc'
