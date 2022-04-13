# Defines for [Homebrew Github personal token, JIRA_BASE_URL, etc]
source ~/.bash_private

# OPEN_COMMAND=open
OPEN_COMMAND=xdg-open

# Use bash-completion, if available
# [[ $PS1 && -f /usr/share/bash-completion/bash_completion ]] && \
    # . /usr/share/bash-completion/bash_completion
#[[ -r "/usr/local/etc/profile.d/bash_completion.sh" ]] && . "/usr/local/etc/profile.d/bash_completion.sh"

#export PATH="/usr/local/opt/php@7.4/bin:$PATH"
#export PATH="/usr/local/opt/php@7.4/sbin:$PATH"

export CLICOLOR=1

alias proj='cd ~/workspace/ddev'
alias composer-install-prod='composer install --no-ansi --no-dev --no-progress --prefer-dist --optimize-autoloader'
alias composer-memory='COMPOSER_MEMORY_LIMIT=-1 composer'
alias ddr='ddev drush'
# Drush 7 fallback installed via global composer require
# https://docs.drush.org/en/7.x/install/
# export DRUSH_LAUNCHER_FALLBACK=$HOME/.composer/vendor/bin/drush
# Drush 8 fallback
export DRUSH_LAUNCHER_FALLBACK=/usr/local/bin/drush8
alias tmuxa='tmux attach-session -t'
alias update-core='composer update drupal/core webflo/drupal-core-require-dev --with-dependencies'
# ddev . 'PHP_IDE_CONFIG="serverName=[servername]" ../vendor/drush/drush/drush [drush command]'
# alias git-delete-merged-remotes="git branch -a --merged |grep feature | sed 's|remotes/origin/||' |xargs git push origin --delete"

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
  [[ -f ".toolboxrc" ]] && toolbox-use
}
export PROMPT_COMMAND=enter_directory

# . "$HOME/.cargo/env"
