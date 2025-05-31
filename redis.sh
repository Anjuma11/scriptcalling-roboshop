#!/bin/bash

source ./common.sh
app_name=redis

check_root

dnf module disable redis -y &>>$LOG_FILE
VALIDATE $? "Disabling default redis"

dnf module enable redis:7 -y &>>$LOG_FILE
VALIDATE $? "Enabling nodejs:7"

dnf install redis -y &>>$LOG_FILE
VALIDATE $? "Installing redis:7" 

sed -i -e 's/127.0.0.-1/0.0.0.0/g' -e '/protected-mode/ c protected-mode no' /etc/redis/reids.conf
VALIDATE $? "Updating redis file to allow remote connections"

systemctl enable redis
VALIDATE $? 'Enabling redis'

systemctl start redis
VALIDATE $? 'Starting redis'