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
wikiDirBackup="/home/human/backups"

#Wiki Path
wikiPath="/var/www/mediawiki"


### MySQL Backup ###

# Set default file perms for backups #
umask 177

# Dump DB into SQL file #
echo "Dumping DB into SQL file"
mysqldump --user=$mysql_User --password=$mysql_Password --host=$mysql_host $mysql_DB > $mysql_backup_path/wiki-db.$date.sql

#Remove backups older than 30 days #
echo "Deleting all backups older than 30 days"

find $mysql_backup_path/* -mtime +30 -exec rm {} \;
find $wikiDirBackup/* -mtime +30 -exec rm {} \;

echo "End MySQL Backup - Start Local File Backup"

### Wiki Directory Backup ###
echo ""
echo "Starting the local backup - This may take a few moments!"
tar cfz $wikiDirBackup/wiki-html.$date.tar.gz $wikiPath
echo "Backed up and compressed the local wiki files"

echo "############################"
echo "# ~Wiki Backup Complete!!~ #"
echo "############################"
