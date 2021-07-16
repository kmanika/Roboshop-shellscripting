#!/bin/bash

LOG=/tmp/roboshop.log
rm -f $LOG

echo -n -e "Installing Nginx\t\t... "
yum install nginx -y &>>$LOG
if [ $? -eq 0 ]; then
  echo -e "\e[32m done\e[0m"
else
  echo fail
fi

### 3. Need to validate whether the script is running as root user not.

echo "Enabling Nginx"
systemctl enable nginx  &>>$LOG
echo $?

echo "Starting Nginx"
systemctl start nginx  &>>$LOG
echo $?


