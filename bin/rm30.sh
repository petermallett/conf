#!/bin/sh
#Deletes any files (other than this one) older then 30 days.
echo "This will delete all files in the current directory which are more than 30 days old."
read -p "Are you sure? " -n 1 -r
if [[ $REPLY =~ ^[Yy]$ ]]
then
  # delete the files
  find . \( ! -name rm30.sh \) -mtime +30 -delete
fi
