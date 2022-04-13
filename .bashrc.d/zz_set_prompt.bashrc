if [ -f "/usr/local/opt/bash-git-prompt/share/gitprompt.sh" ]; then
  __GIT_PROMPT_DIR="/usr/local/opt/bash-git-prompt/share"
  source "/usr/local/opt/bash-git-prompt/share/gitprompt.sh"
elif [ -f "/usr/share/git-core/contrib/completion/git-prompt.sh" ]; then
  __GIT_PROMPT_DIR="//usr/share/git-core/contrib/completion"
  . "$__GIT_PROMPT_DIR/git-prompt.sh"
fi
export GIT_PS1_SHOWDIRTYSTATE=1

TOOLBOX_NAME=$(istoolbx)
if [ $? -eq 0 ]; then
  export PATH="$HOME/.npm-global/bin:$PATH"
  export PS1='[\u@\h[$TOOLBOX_NAME] \w]$(__git_ps1 " (%s)")\n \$ '
else
  export PS1='[\u@\h \w]$(__git_ps1 " (%s)")\n \$ '
fi
