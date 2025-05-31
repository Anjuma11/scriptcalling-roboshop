#!/bin/bash

source ./common.sh
app_name=mysql

check_root

echo "Please enter root password to setup"
read -s MYSQL_ROOT_PASSWORD


dnf install mysql-server -y
VALIDATE $? 'Installing mysql server'

systemctl enable mysqld
VALIDATE $? 'Enabling mysql server'

systemctl start mysqld
VALIDATE $? 'Started mysql server'

mysql_secure_installation --set-root-pass $MYSQL_ROOT_PASSWORD &>>$LOG_FILE
VALIDATE $? "Setting MySQL root password"

print_time