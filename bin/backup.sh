#!/bin/sh

backupPath=

if [[ -n $1 ]]; then
  backupPath=$1
else
  backupPath="/Users/petermallett/workspace"
fi

now=$(date +"%Y-%m-%d")
dirname=$(basename "$backupPath")
cd $backupPath

backupDest="/Volumes/ESD-USB/mcBackup/"
echo "backing up $backupPath to $backupDest$dirname-$now.tar.gz"
tar -czf $backupDest$dirname-$now.tar.gz *

# cd /Volumes/500GB\ HDD/backups/
# rm30.sh
