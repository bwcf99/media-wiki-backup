#!/bin/bash
# Authors:
# Brent Fagersten
# Parker Desborough
# Christopher Contonio
# Joseph Soens


##### ~CONFIG~ #####

# MySQL Config #
mysql_host="localhost"
mysql_User="root"
mysql_Password="root"
mysql_DB="mediawiki"
date=$(date +"%y-%m-%d-%H-%M-%S")

# Remote Backup Paths #
mysql_backup_path="/home/human/backups"
wikiHtmlBackup="/home/human/backups"

# Remote Server Credentials #
remoteHost="localhost"
remoteHost_username="human"

# Wiki Path
wikiPath="/var/www/mediawiki"


##### END CONFIG #####


##### MySQL Backup #####

# Set default file perms for backups #
umask 177

# Dump DB into SQL file #
echo "Dumping DB into SQL file"
mkdir /tmp/wikiBackup/ # Create wikiBackup tmp file.
mysqldump --user=$mysql_User --password=$mysql_Password --host=$mysql_host $mysql_DB > /tmp/wikiBackup/wiki-db.dump.sql #dump the sql to the .sql file
echo "Compressing SQL Dump"

tar zcf /tmp/wikiBackup/wiki-db.$date.tar.gz /tmp/wikiBackup/wiki-db.dump.sql # Compress the sql file
rm -rf /tmp/wikiBackup/wiki-db.dump.sql # Remove the uncompressed .sql file.

# Remove backups older than 7 days ### No longer working for remote hosts
echo "Deleting all backups older than 7 days"

ssh $remoteHost@$remoteHost_username find $mysql_backup_path/* -mtime +7 -exec rm {} \; # Delete any DB backups older than 7 days
ssh $remoteHost@$remoteHost_username find $wikiHtmlBackup/* -mtime +7 -exec rm {} \; #delete any HTML backup older than 7 days

echo "End MySQL Backup - Start Local File Backup"

##### END MySQL Backup #####



##### Wiki Directory Backup #####
echo "Starting the local HTML backup - This may take a few moments!"
echo "."
echo ".."
echo "..."
echo ".."
echo "."
tar cfz /tmp/wikiBackup/wiki-html.$date.tar.gz $wikiPath # Compress/move HTML files to /tmp/wikiBackup
echo "Backed up and compressed the local wiki files!"



##### Export Backups #####
echo "Exporting backups to remote server"
scp /tmp/wikiBackup/wiki-html.* $remoteHost_username@$remoteHost:$wikiHtmlBackup # Export HTML backup
scp /tmp/wikiBackup/wiki-db.* $remoteHost_username@$remoteHost:$mysql_backup_path # Export DB backup.

rm -rf /tmp/wikiBackup # Remove the tmp file.
echo "Backups exported!"

#### End Export Backups #####


echo "############################"
echo "# ~Wiki Backup Complete!!~ #"
echo "############################"
