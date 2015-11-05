# media-wiki-backup
Media wiki backup solution for a sysadmin class group project.

This backup solution will backup the mysql DB and HTML files for media wiki.

## Setup
### Set Cron Job: 
0 0,4,8,12,16,20 * * * /command.sh
### Create SSH Keys
1. On remote Server run the command "ssh-keygen -t rsa"
2. send the key to the master server (in our case "cat id_rsa.pub |ssh christophercontonio@10.0.5.90 "mkdir -p ~/.ssh && cat >> ~/.ssh/authorized_keys")
3. Remote keys setup!


## Configuration
Edit the configuration section at the top of the mediawiki-backup.sh file to match your needs.

Notice: Without SSH Keys backups will not be automatic!
