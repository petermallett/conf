
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
alias drushmc='drush $(drush sa | grep ^@\.*\.mcdev)'
alias ddx='ddev . disable_xdebug'
alias dex='ddev . enable_xdebug'
# ddev . 'PHP_IDE_CONFIG="serverName=[servername]" drush [drush command]'
# ddev . 'PHP_IDE_CONFIG="serverName=cms-magmutual.ddev.local" drush mim upgrade_d7_node_article --idlist=10526'
# alias git-delete-merged-remotes="git branch -a --merged |grep feature | sed 's|remotes/origin/||' |xargs git push origin --delete"
termtitle() {
  name=`hostname` echo -n -e "\033]0;$1 $name\007"
}

bit() {
  NAME=$(basename `git rev-parse --show-toplevel`)
  open "https://bitbucket.org/mediacurrent/$NAME/branch/$1"
}
jira() {
  open "http://codeandtheory.atlassian.net/browse/$1"
}

alias vagrant-cmdlist='echo vagrant-xdebug [enable|disable] vagrant_debug_is_enabled drush_vdebug'
alias vagrant_debug_is_enabled='vagrant ssh -c "php -i | grep xdebug.support"'
# ddev . 'export PHP_IDE_CONFIG="serverName=cms-magmutual.ddev.local"; drush mim upgrade_d7_node_article'
drush_vdebug () {
  USAGE=$'Usage: drush_vdebug <servername> --uri=http://site.mcdev <drush-command>\n\n'
  USAGE+=$'ARGUMENTS:\n'
  USAGE+=$'  <servername>: The server configuration name in PHPStorm\n'
  USAGE+=$'  <drush-command>: The Drush command followed by any additional arguments for Drush'

  if [[ $# -lt 3 ]]; then
    echo "$USAGE"
    return 1
  fi

  SERVERNAME="$1"
  shift 1
  SSHCOMMAND="export PHP_IDE_CONFIG=\"serverName=$SERVERNAME\"; export XDEBUG_CONFIG=\"idekey=PHPSTORM\"; cd docroot/web; ../vendor/drush/drush/drush.launcher $@"

  echo "Executing SSH Command: \"$SSHCOMMAND\""
  vagrant ssh -c "$SSHCOMMAND"
}
drush_vdebug7 () {
  SERVERNAME="$1"
  shift 1
  SSHCOMMAND="export PHP_IDE_CONFIG=\"serverName=$SERVERNAME\"; export XDEBUG_CONFIG=\"idekey=PHPSTORM\"; cd docroot; drush $@"

  echo "Executing SSH Command: \"$SSHCOMMAND\""
  vagrant ssh -c "$SSHCOMMAND"
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
export PATH="/usr/local/opt/php@7.2/bin:$PATH"
export PATH="/usr/local/opt/php@7.2/sbin:$PATH"
