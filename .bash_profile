source ~/.profile

alias gitinfo="git-info.sh | less"
alias gitl="git log --oneline --decorate --graph"
alias gitsrp="git stash; git rebase; git stash pop"
alias gitlast='for k in $(git branch|perl -pe s/^..//);do echo -e $(git show --pretty=format:"%Cgreen%ci %Cblue%cr%Creset" $k|head -n 1)\\t$k;done|sort -r'
alias gitx="open /Applications/GitX.app ."
alias termtitle='name=`hostname` echo -n -e "\033]0;$name\007"'
alias drush-debug='XDEBUG_CONFIG="idekey=ide-key" drush $*'
alias gvimdiff='mvim -d'
alias fuck='$(thefuck $(fc -ln -1))'

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

#Homebrew Github personal token
export HOMEBREW_GITHUB_API_TOKEN=6cc0de69d404ffc28726ac69993a94f4d7a22d8c

# Include private stuff.
#let $LOCALFILE=expand('~/.EXAMPLE-private')
# if filereadable($LOCALFILE)
#  source $LOCALFILE
# endif

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
