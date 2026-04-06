#!/bin/bash

# Script for the systemd deja-dup-ignore.timer
find ~/ -name node_modules -prune -exec touch {}/.deja-dup-ignore \;
#find ~/ -name .deja-dup-ignore
