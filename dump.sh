#!/bin/sh 
DUMP=/usr/bin/mysqldump # MySQL Dump Bin
OUT_DIR=/data/db_backup # Backup save path
LINUX_USER=root #Linux USER
DB_NAME=mysql #DB Name
DB_USER=mysql_user #DB User
DB_PASS=mysql_password #DB password
DAYS=7 #Backup file exp day
cd $OUT_DIR
DATE=`date +%Y%m%d%H%M`
OUT_SQL=$DATE.sql
TAR_SQL="mysql_bak_$DATE.tar.gz"
$DUMP -u$DB_USER -p$DB_PASS $DB_NAME --default-character-set=utf8 --opt -Q -R --skip-lock-tables>$OUT_SQL
tar -czf $TAR_SQL ./$OUT_SQL
rm $OUT_SQL
chown $LINUX_USER:$LINUX_USER $OUT_DIR/$TAR_SQL
find $OUT_DIR -name "mysql_bak*" -type f -mtime +$DAYS -exec rm {} \;
