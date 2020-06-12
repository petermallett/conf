export BASH_SILENCE_DEPRECATION_WARNING=1

source ~/.bash_private
export PATH=/usr/local/sbin:$HOME/bin:$HOME/.composer/vendor/bin:$PATH
export GOPATH=~/workspace/go

export CLICOLOR=1

export NVM_DIR="$HOME/.nvm"
. "/usr/local/opt/nvm/nvm.sh"
[[ -r $NVM_DIR/bash_completion ]] && \. $NVM_DIR/bash_completion

alias gitl="git log --oneline --decorate --graph"
alias gitsrp="git stash; git rebase; git stash pop"
alias gitlast='for k in $(git branch|perl -pe s/^..//);do echo -e $(git show --pretty=format:"%Cgreen%ci %Cblue%cr%Creset" $k|head -n 1)\\t$k;done|sort -r'
alias git-shame='git-branches-by-commit-date.sh'
alias proj='cd ~/workspace/ddev'
alias composer-install-prod='composer install --no-ansi --no-dev --no-progress --prefer-dist --optimize-autoloader'
alias composer-memory='COMPOSER_MEMORY_LIMIT=-1 composer'
alias drushmc='drush $(drush sa | grep ^@\.*\.mcdev)'
alias ddrush='ddev . drush'
export DRUSH_LAUNCHER_FALLBACK=/usr/local/bin/drush8
alias python=python3
alias tmuxa='tmux attach-session -t'
alias update-core='composer update drupal/core webflo/drupal-core-require-dev --with-dependencies'
# ddev . 'PHP_IDE_CONFIG="serverName=[servername]" ../vendor/drush/drush/drush [drush command]'
# alias git-delete-merged-remotes="git branch -a --merged |grep feature | sed 's|remotes/origin/||' |xargs git push origin --delete"
termtitle() {
  name=`hostname` echo -n -e "\033]0;$1 $name\007"
}

bit() {
  NAME=$(basename $(git rev-parse --show-toplevel))
  BRANCH=$(git rev-parse --abbrev-ref HEAD)
  open "https://bitbucket.org/mediacurrent/"$NAME"/branch/$BRANCH"
}

alias gvimdiff='mvim -d'

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
RESET="\033[0m";
BLUE="\033[38;5;63m";
PS1='[\w \t\[\033[0;32m\]$(__git_ps1 " (%s)")'"\["$RESET"\]]\n"
PS1+="\["$BLUE"\]⇒  \["$RESET"\]"

enter_directory() {
  if [[ $PWD == $PREV_PWD ]]; then
    return
  fi

  PREV_PWD=$PWD
  [[ -f ".nvmrc" ]] && nvm use
}
export PROMPT_COMMAND=enter_directory

if [ $ITERM_SESSION_ID ]; then
  export PROMPT_COMMAND='echo -ne "\033];${PWD##*/}\007"; '"$PROMPT_COMMAND";
fi

export PATH="$HOME/.cargo/bin:$PATH"
export PATH="/usr/local/opt/php@7.3/bin:$PATH"
export PATH="/usr/local/opt/php@7.3/sbin:$PATH"

test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash" || true
