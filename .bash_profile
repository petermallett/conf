export BASH_SILENCE_DEPRECATION_WARNING=1

# Defines for [Homebrew Github personal token, JIRA_BASE_URL, etc]
source ~/.bash_private

[[ -r "/usr/local/etc/profile.d/bash_completion.sh" ]] && . "/usr/local/etc/profile.d/bash_completion.sh"

export PATH="/usr/local/opt/php@7.4/bin:$PATH"
export PATH="/usr/local/opt/php@7.4/sbin:$PATH"
export PATH=/usr/local/sbin:$HOME/bin:$PATH:$HOME/.composer/vendor/bin
export GOPATH=~/workspace/go

export DENO_INSTALL="/Users/pmallett/.deno"
export PATH="$DENO_INSTALL/bin:$PATH"

export CLICOLOR=1

export NVM_DIR="$HOME/.nvm"
. "/usr/local/opt/nvm/nvm.sh"
[[ -r $NVM_DIR/bash_completion ]] && \. $NVM_DIR/bash_completion

alias gitl="git log --oneline --decorate --graph"
alias gitsrp="git stash; git rebase; git stash pop"
alias gfasd="git fetch && git switch develop"
alias gitlast='for k in $(git branch|perl -pe s/^..//);do echo -e $(git show --pretty=format:"%Cgreen%ci %Cblue%cr%Creset" $k|head -n 1)\\t$k;done|sort -r'
alias git-shame='git-branches-by-commit-date.sh'
alias proj='cd ~/workspace/ddev'
alias composer-install-prod='composer install --no-ansi --no-dev --no-progress --prefer-dist --optimize-autoloader'
alias composer-memory='COMPOSER_MEMORY_LIMIT=-1 composer'
alias ddr='ddev drush'
# Drush 7 fallback installed via global composer require
# https://docs.drush.org/en/7.x/install/
# export DRUSH_LAUNCHER_FALLBACK=$HOME/.composer/vendor/bin/drush
# Drush 8 fallback
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
bitpr() {
  NAME=$(basename $(git rev-parse --show-toplevel))
  open "https://bitbucket.org/mediacurrent/"$NAME"/pull-requests/"
}

jira() {
  if echo "$1" | grep '[0-9]' >/dev/null; then
    open "$JIRA_BASE_URL/browse/$1"
  else
    open "$JIRA_BASE_URL/projects/$1"
  fi
}

wiki() {
  open "$JIRA_BASE_URL/wiki/spaces/$1"
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

if [ -f "/usr/local/opt/bash-git-prompt/share/gitprompt.sh" ]; then
  __GIT_PROMPT_DIR="/usr/local/opt/bash-git-prompt/share"
  source "/usr/local/opt/bash-git-prompt/share/gitprompt.sh"
fi

# RESET="\033[0m";
# BLUE="\033[38;5;63m";
# PS1='[\w \t\[\033[0;32m\]$(__git_ps1 " (%s)")'"\["$RESET"\]]\n"
# PS1+="\["$BLUE"\]⇒  \["$RESET"\]"
. "$HOME/.cargo/env"
function blt() {
  if [[ ! -z ${AH_SITE_ENVIRONMENT} ]]; then
    PROJECT_ROOT="/var/www/html/${AH_SITE_GROUP}.${AH_SITE_ENVIRONMENT}"
  elif [ "`git rev-parse --show-cdup 2> /dev/null`" != "" ]; then
    PROJECT_ROOT=$(git rev-parse --show-cdup)
  else
    PROJECT_ROOT="."
  fi

  if [ -f "$PROJECT_ROOT/vendor/bin/blt" ]; then
    $PROJECT_ROOT/vendor/bin/blt "$@"

  # Check for local BLT.
  elif [ -f "./vendor/bin/blt" ]; then
    ./vendor/bin/blt "$@"

  else
    echo "You must run this command from within a BLT-generated project."
    return 1
  fi
}
