#!/bin/bash

if [ $HOME != $PWD ]; then
  echo "Run this from the home directory. eg:"
  echo "> cd ~; ./conf/bin/install"
  exit 1
fi

skip_files=(. .. .git README.md)
for f in $(find $PWD/conf/ -maxdepth 1)
do
    name=$(basename "$f")
    for g in "${skip_files[@]}" ; do
        [ "$name" = "$g" ] && continue 2
    done

    if [[ -d "$f" ]]; then
        echo ">  "$f" is a directory, linking contents..."
        echo ">  mkdir -p ~/"$name""
        mkdir -p ~/"$name"
        echo ">  ln -s "$f"/* ~/"$name"/"
        ln -sr "$f"/* ~/"$name"/
    else
        echo ">  ln -s "$f" ~"
        ln -s "$f" ~
    fi
done

echo "Cloning Tmux Plugin Manager..."
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

systemd_dir="$PWD/conf/.config/systemd/user"
if [ -d "$systemd_dir" ] && [[ ! -z "$( ls -A "$systemd_dir" )" ]]; then
    echo "Starting new systemd services from $systemd_dir/ ..."
    echo Running systemctl --user daemon-reload
    systemctl --user daemon-reload
    for f in "$systemd_dir/"*.{service,timer}
    do
        name=$(basename "$f")
        echo checking $name
        if systemctl is-active --quiet "$name"; then
            echo $name service is already active from a previous install
        else
            systemctl --user start $name
            systemctl --user status $name
            if [[ "$?" -ne 0 ]]; then
                echo Start for "$name" failed.
            else
                echo Start for "$name" succeeded, enabling...
                systemctl --user enable $name
            fi
        fi
    done
    echo to see active --user timers:
    echo systemctl list-timers --user
fi;
