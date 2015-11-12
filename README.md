# media-wiki-backup
Media wiki backup solution for a sysadmin class group project.

This backup solution will backup the mysql DB and HTML files for media wiki.

## Setup
### Set Cron Job: 
0 0,4,8,12,16,20 * * * /mediawiki-backup.sh
### Create SSH Keys
1. On remote Server run the command "ssh-keygen -t rsa"
2. send the key to the master server (in our case "cat id_rsa.pub |ssh christophercontonio@10.0.5.90 "mkdir -p ~/.ssh && cat >> ~/.ssh/authorized_keys")
3. Remote keys setup!


## Configuration
Edit the configuration section at the top of the mediawiki-backup.sh file to match your needs.

1. MySQL Config: change to match the MySQL config
2. Date Format: Change the date format. Guide: http://www.cyberciti.biz/faq/linux-unix-formatting-dates-for-display/
3. Remote Backup Paths: The path you would like the backups to be stored to on the remote server.
4. Remote Server Credentials: The hostname/username for the remote backup storage server
5. Wikipath: The installation path of Media Wiki


Notice: Without SSH Keys backups will not be automatic!


## Team Breakdown
Cron Job: Parker D

SSH Keys and linux dev Environemnt: Christopher C

Backup Script: Brent F

Technical Writer: Joseph S
