#!/bin/bash

if [ $HOME != $PWD ]; then
  echo "Run this from the home directory. eg:"
  echo "> cd ~; ./conf/bin/install"
  exit 1
fi

skip_files=(. .. .git README.md)
for f in $PWD/conf/.*
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
