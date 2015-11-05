#!/bin/bash

### CONFIG ###

#MySQL Config#
mysql_host="localhost"
mysql_User="root"
mysql_Password="root"
mysql_DB="mediawiki"
date=$(date +"%y-%m-%d-%H-%M-%S")

#Backup Paths#
mysql_backup_path="/home/human/backups"


### MySQL Backup ###

# Set default file perms for backups #
umask 177

# Dump DB into SQL file #
echo "Dumping DB into SQL file"
mysqldump --user=$mysql_User --password=$mysql_Password --host=$mysql_host $mysql_DB > $mysql_backup_path/$mysql_DB-$date.sql

#Remove backups older than 30 days #
echo "Deleting all backups older than 30 days"

find $mysql_backup_path/* -mtime +30 -exec rm {} \;
