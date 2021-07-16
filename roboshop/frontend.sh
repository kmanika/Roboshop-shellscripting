#!/bin/bash

source common.sh

PRINT "Installing Nginx"
yum install nginx -y &>>$LOG
STAT_CHECK $?

### 3. Need to validate whether the script is running as root user not.

PRINT "Enabling Nginx\t"
systemctl enable nginx  &>>$LOG
STAT_CHECK $?

PRINT "Starting Nginx\t"
systemctl start nginx  &>>$LOG
STAT_CHECK $?

