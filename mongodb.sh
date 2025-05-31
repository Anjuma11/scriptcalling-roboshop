#!/bin/bash

source ./common.sh
app_name=mongodb

check_root()

cp $SCRIPT_DIR/mongo.repo /etc/yum.repos.d/mongodb.repo
VALIDATE $? "Copying mongo repo file"

dnf install mongodb-org -y
VALIDATE $? "Installing mongodb"

systemctl enable mongod
VALIDATE $? "Enabling mongod"

systemctl start mongod
VALIDATE $? "Starting mongod"

sed -e 's/127.0.0.-1/0.0.0.0/g' /etc/mongod.conf
VALIDATE $? "Updating mongod file to allow remote connections"

systemctl restart mongod
VALIDATE $? "Restarting mongod"
