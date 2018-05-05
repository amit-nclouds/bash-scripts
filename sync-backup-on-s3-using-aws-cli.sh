#!/bin/bash
/usr/bin/printf '\e[1;37m%-6s\e[m\n' "started s3 sync job: `date`"
time=`/bin/date`
/usr/bin/aws s3 sync /backups/production_backup s3://backups/production_backup --no-progress
if [ "$?" -eq "0" ]; then

/usr/bin/printf '\e[1;37m%-6s\e[m\n' "`date` :Completed Successfully"

/usr/bin/printf '\e[1;37m%-6s\e[m\n' "`date` :sending mail"
duration=$SECONDS
read -r -d '' VAR <<- EOM
To: user1@test.com,user2@test.com
Subject: Backup Completed Successfully!
From: backup_noreply@test.com

Backup Completed Successfully!

Job: Backup sync to s3 
backup started at $time
bcakup completed at `/bin/date`
`/bin/echo " sync to s3 took $((($duration / 60) / 60 )) hour $(($duration / 60)) minutes and $(($duration % 60)) seconds"`
EOM

#echo "$VAR"

/bin/echo "$VAR" | /usr/bin/sendmail -vt
else
/usr/bin/printf '\e[1;37m%-6s\e[m\n' "`date` :sync  failed"
/usr/bin/printf '\e[1;37m%-6s\e[m\n' "`date` :sending mail"
duration=$SECONDS
read -r -d '' VAR2 <<- EOM
To: user1@test.com,user2@test.com
Subject: s3 Backup Failed !
From: backup_noreply@test.com

Job: Backup sync to s3 
backup started at $time
bcakup failed  at `/bin/date`
`/bin/echo " process took took $((($duration / 60) / 60 )) hour $(($duration / 60)) minutes and $(($duration % 60)) seconds"`

logs:-
`/usr/bin/tail /home/amit/ncloud_scripts/main_db_s3_sync.logs`

EOM
#echo "$VAR2"

/bin/echo "$VAR2" | /usr/bin/sendmail -vt

fi