source ~/.profile

alias gitinfo="git-info.sh | less"
alias gitl="git log --oneline --decorate --graph"
alias gitx="open /Applications/GitX.app ."
alias termtitle='name=`hostname` echo -n -e "\033]0;$name\007"'
alias drush-debug='XDEBUG_CONFIG="idekey=netbeans-xdebug" drush $*'
alias drush-sql-drop='drush sql-dump | grep DROP | drush sql-cli'
alias ls="ls -G"

up () {
  if [ -z $1 ]; then
    cd ..
  elif [ $1 -gt 0 ]; then
    let count=0
    while [ $count -lt $1 ]; do
      cd ..
      let count=count+1
    done
  else
    echo "Argument must be a positive integer."
  fi
  pwd
}

if [ -f `brew --prefix`/etc/bash_completion ]; then
  . `brew --prefix`/etc/bash_completion
fi

GIT_PS1_SHOWSTASHSTATE=true
PS1=' [\u \w \t\[\033[0;32m\]$(__git_ps1 " (%s)")\[\033[0m\]]\n$ '

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

