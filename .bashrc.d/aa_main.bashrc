# Defines for [Homebrew Github personal token, JIRA_BASE_URL, etc]
source ~/.bash_private

bash_open () {
  # open "$1"
  xdg-open "$1" > /dev/null 2>&1
}

export CLICOLOR=1

alias proj='cd ~/workspace'
alias composer-install-prod='composer install --no-ansi --no-dev --no-progress --prefer-dist --optimize-autoloader'
alias composer-memory='COMPOSER_MEMORY_LIMIT=-1 composer'
alias ddr='ddev drush'
alias lsd='ls --color -lh --group-directories-first'
# Drush 7 fallback installed via global composer require
# https://docs.drush.org/en/7.x/install/
# export DRUSH_LAUNCHER_FALLBACK=$HOME/.composer/vendor/bin/drush
# Drush 8 fallback
export DRUSH_LAUNCHER_FALLBACK=/usr/local/bin/drush8
alias tmuxa='tmux attach-session -t'
alias update-core='composer update drupal/core webflo/drupal-core-require-dev --with-dependencies'
# ddev . 'PHP_IDE_CONFIG="serverName=[servername]" ../vendor/drush/drush/drush [drush command]'
# alias git-delete-merged-remotes="git branch -a --merged |grep feature | sed 's|remotes/origin/||' |xargs git push origin --delete"
alias dockerpsa='docker ps -a --format "table {{.Names}}\t {{.Status}}"'
alias podmanpsa='podman ps -a --format "table {{.Names}}\t {{.Status}}"'

export HISTTIMEFORMAT="%d/%m/%y %T "

export DENO_INSTALL="/home/pmallett/.deno"
export PATH="$DENO_INSTALL/bin:$PATH"

loho () {
  if echo "$1" | grep '[0-9]' >/dev/null; then
    PORT=$1
  else
    PORT=3000
  fi
  bash_open "http://localhost:$PORT"
}

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
