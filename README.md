# bash-scripts

 ##### sync backup to s3 using AWS cli script for cron 
  script name:-sync-backup-on-s3-using-aws-cli.sh
######  scripts features:-
 script sends notified the status of backup (succeeded or failed) to the users by email.
along with the status it's also tells in how much time s3 sync has completed.


######  scripts components:-

- AWS cli 
- sendmail

######  how to use:-
`/bin/bash sync-backup-on-s3-using-aws-cli.sh >> /home/amit/ncloud_scripts/main_db_s3_sync.logs`