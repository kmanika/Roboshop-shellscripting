#!/bin/bash

LOG=/tmp/roboshop.log
rm -f $LOG

echo -e "Installing Nginx\t\t... \e[32mdone\e[0m"
yum install nginx -y &>>$LOG
### 1. Output from commands should not be displayed on screen
### 2. Validate the command is successful or not
### 3. Need to validate whether the script is running as root user not.

echo "Enabling Nginx"
systemctl enable nginx  &>>$LOG

echo "Starting Nginx"
systemctl start nginx  &>>$LOG

