#!/bin/bash

if [ $HOME != $PWD ]; then
  echo "Run this from the home directory. eg:"
  echo "> cd ~; ./conf/bin/install"
  exit 1
fi

skip_files=(. .. .git README.md)
for f in $PWD/conf/.*
do
    skip_this=0
    name=$(basename "$f")

    for g in "${skip_files[@]}" ; do
        [ "$name" = "$g" ] && skip_this=1
    done
    [ "$skip_this" = 0 ] && ln -s "$f" ~
done
