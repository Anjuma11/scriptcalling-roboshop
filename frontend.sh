#!/bin/bash

source ./common.sh
app_name=frontend

check_root

dnf module disable nginx -y &>>$LOG_FILE
VALIDATE $? "Disabling default nginx"

dnf module enable nginx:1.24 -y &>>$LOG_FILE
VALIDATE $? "Enabling nginx:20"

dnf install nginx -y &>>$LOG_FILE
VALIDATE $? "Installing nginx:1.24"

systemctl enable nginx
VALIDATE $? "Enabling  nginx"

systemctl start nginx
VALIDATE $? "Started nginx"

rm -rf /usr/share/nginx/html/*
VALIDATE $? "Removing default html"

curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend-v3.zip &>>$LOG_FILE
VALIDATE $? "Downloading frontend code"

cd /usr/share/nginx/html 
unzip /tmp/frontend.zip &>>$LOG_FILE
VALIDATE $? "unzipping frontend"

rm -rf /etc/nginx/nginx.conf

cp $SCRIPT_DIR/nginx.conf /etc/nginx/nginx.conf
VALIDATE $? "Updating nginx conf file"

systemctl restart nginx
VALIDATE $? "restarting nginx"


print_time