GITPROMPT_LOCATIONS=(
    "/usr/local/opt/bash-git-prompt/share/gitprompt.sh"
    "/usr/share/git-core/contrib/completion/git-prompt.sh"
)
for F in "${GITPROMPT_LOCATIONS[@]}"; do
    if [ -f "$F" ]; then
        source "$F"
        break
    fi
done

function enter_directory {
  if [[ $PWD == $PREV_PWD ]]; then
    return
  fi
  PREV_PWD=$PWD

  # [[ -f ".toolboxrc" ]] && toolbox-use
  # [[ -f ".nvmrc" ]] && nvm use
}
export PROMPT_COMMAND=enter_directory

TOOLBOX_NAME=$(istoolbx)
if [ $? -eq 0 ]; then
  export PATH="$HOME/.npm-global/bin:$PATH"
  export TOOLBOX_PS1="\e[94m [$TOOLBOX_NAME]\e[0m"
fi

export PS1='[\u@\h$(echo -e $TOOLBOX_PS1) \w]$(__git_ps1 "\e[94m (%s)\e[0m")\n \$ '
