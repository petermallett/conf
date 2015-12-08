#!/bin/sh

backupPath=

if [[ -n $1 ]]; then
  backupPath=$1
fi

if [[ -n backupDir ]]; then
  backupPath="/Users/petermallett/workspace"
fi

now=$(date +"%Y-%m-%d")
dirname=$(basename "$backupPath")
backupFile=""

cd $backupPath
echo "backing up $backupPath to /Volumes/500GB\ HDD/backups/$dirname-$now.tar.gz"
tar -czf /Volumes/500GB\ HDD/backups/$dirname-$now.tar.gz *

# cd /Volumes/500GB\ HDD/backups/
# rm30.sh
