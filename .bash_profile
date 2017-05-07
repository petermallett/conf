source ~/.profile
source ~/.bash_private

alias gitinfo="git-info.sh | less"
alias gitl="git log --oneline --decorate --graph"
alias gitsrp="git stash; git rebase; git stash pop"
alias gitlast='for k in $(git branch|perl -pe s/^..//);do echo -e $(git show --pretty=format:"%Cgreen%ci %Cblue%cr%Creset" $k|head -n 1)\\t$k;done|sort -r'
alias git-shame='git-branches-by-commit-date.sh'
alias gitx="open /Applications/GitX.app ."
alias termtitle='name=`hostname` echo -n -e "\033]0;$name\007"'

vagrant_param_echo_version () {
  DEFAULT=7.0
  echo ${1-$DEFAULT}
}
vagrant_param_echo_phptype () {
  DEFAULT=cli
  echo ${1-$DEFAULT}
}
vagrant_debug_enable () {
  version=$(vagrant_param_echo_version $1)
  phptype=$(vagrant_param_echo_phptype $2)
  vagrant ssh -c "sudo mv /etc/php/$version/$phptype/conf.d/20-xdebug.ini.disabled /etc/php/$version/$phptype/conf.d/20-xdebug.ini"
}
vagrant_debug_disable () {
  version=$(vagrant_param_echo_version $1)
  phptype=$(vagrant_param_echo_phptype $2)
  vagrant ssh -c "sudo mv /etc/php/$version/$phptype/conf.d/20-xdebug.ini /etc/php/$version/$phptype/conf.d/20-xdebug.ini.disabled"
}
alias vagrant_debug_is_enabled='vagrant ssh -c "php -i | grep xdebug.support"'

jira() {
  open "http://codeandtheory.atlassian.net/browse/$1"
}
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

# Updates PATH for the Google Cloud SDK.
source '/Users/petermallett/workspace/google-cloud-sdk/path.bash.inc'
# Enable bash completion for gcloud.
source '/Users/petermallett/workspace/google-cloud-sdk/completion.bash.inc'

# Init rbenv
eval "$(rbenv init -)"
