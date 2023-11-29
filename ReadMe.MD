 
Comprehensive Guide: MongoDB Backup, Secure Transfer, and Automated Deletion 

Complete documentation that covers the process of creating a Jenkins pipeline to perform MongoDB backup, transfer the backup to a target server, and set up a cron job for automatic deletion of older backup files. The documentation is divided into sections for clarity. 

   

1.Jenkinsfile 

Three stages – MongoDB Backup, SCP Transfer & Delete Local Backup 
Jenkinsfile to define the pipeline steps. 


2.MongoDB Backup Stage 

 In the Jenkinsfile, the MongoDB backup stage uses the `mongodump` command to perform a database backup and compress it into a `.tar.gz` file. The backup file is named with the current date. 


3.SCP Transfer Stage 

The SCP Transfer stage uses the `scp` command to securely transfer the backup file from the Jenkins server to the target server. 

 
4.Delete Local Backup Stage 

The 'Delete Local Backup' stage deletes the local backup file on the Jenkins server after successful transfer to the target server. 

  
Automatic Deletion of Older Backup Files 

 1.Script to Delete Older Backups 

Created a script named `old_backups.sh` on the target server: 

This scripts finds & deletes the file which is older than 7 days  


2. Made the script executable:


3.Cron Job 

Scheduled the script to run daily using a cron job: 
- Open your crontab for editing: 
- Added the following line to schedule the script to run every day at midnight: 
 Make sure to replace `/path/to/delete_old_backups.sh` with the actual path to your script. 

Summary 
This documentation provides a comprehensive guide to creating a Jenkins pipeline for MongoDB backup and transfer, along with an automatic deletion process for older backup files on the target server. The pipeline ensures backups are transferred securely and locally stored files are managed efficiently. The cron job automates the deletion of older files, maintaining data cleanliness on the target server. 
