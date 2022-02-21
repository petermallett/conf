#!/bin/bash

pushd . >/dev/null
# Find base of git directory
while [ ! -d .git ] && [ ! `pwd` = "/" ]; do cd ..; done

git shortlog -s -n --all --no-merges

popd >/dev/null
