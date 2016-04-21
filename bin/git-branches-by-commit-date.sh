#!/bin/sh
# Credit http://stackoverflow.com/a/2514279
for branch in `git branch -r $1 | grep origin | grep -v HEAD`;do echo -e `git show --format="%ci %cr %aE" $branch | head -n 1` \\t$branch; done | sort -r
