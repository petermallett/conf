#!/bin/sh

drush sqlq "DELETE FROM variable WHERE name LIKE 'cron_%';"
drush sqlq "DELETE FROM semaphore WHERE name='cron' LIMIT 1;"
