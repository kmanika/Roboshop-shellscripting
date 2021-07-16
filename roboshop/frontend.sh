#!/bin/bash

LOG=/tmp/roboshop.log
rm -f $LOG

echo -n -e "Installing Nginx\t\t..."
yumm install nginx -y &>>$LOG
if [ $? -eq 0 ]; then
  echo -e "\e[32m done\e[0m"
else
  echo fail
fi

### 3. Need to validate whether the script is running as root user not.

echo -n -e "Enabling Nginx\t\t\t..."
systemctl enable nginx  &>>$LOG
if [ $? -eq 0 ]; then
  echo -e "\e[32m done\e[0m"
else
  echo fail
fi

echo -n -e "Starting Nginx\t\t\t..."
systemctl start nginx  &>>$LOG
if [ $? -eq 0 ]; then
  echo -e "\e[32m done\e[0m"
else
  echo fail
fi


