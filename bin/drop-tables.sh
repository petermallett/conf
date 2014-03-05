#!/bin/sh

mysqldump -u[USERNAME] -p[PASSWORD] --add-drop-table --no-data [DATABASE] | grep ^DROP | mysql -u[USERNAME] -p[PASSWORD] [DATABASE]
