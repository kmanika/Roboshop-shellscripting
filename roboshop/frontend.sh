#!/bin/bash

source common.sh

PRINT "Installing Nginx\t"
yum install nginx -y &>>$LOG
STAT_CHECK $?

PRINT "Download Frontend\t"
curl -s -L -o /tmp/frontend.zip "https://github.com/roboshop-devops-project/frontend/archive/main.zip" &>>$LOG
STAT_CHECK $?


PRINT "Remove Old HtDocs\t"
cd /usr/share/nginx/html &>>$LOG && rm -rf * &>>$LOG
STAT_CHECK $?

PRINT "Extract Frontend Archive"
unzip /tmp/frontend.zip &>>$LOG && mv frontend-main/* . &>>$LOG && mv static/* . &>>$LOG  && rm -rf frontend-master static &>>$LOG
STAT_CHECK $?

PRINT "Copy RoboShop Config\t"
mv localhost.conf /etc/nginx/default.d/roboshop.conf &>>$LOG
STAT_CHECK $?

PRINT "Update RoboShop Config\t"
sed -i -e '/catalogue/ s/localhost/catalogue.devops.jcp/' -e '/user/ s/localhost/user.devops.jcp/'  -e '/cart/ s/localhost/cart.devops.jcp/' -e '/shipping/ s/localhost/shipping.devops.jcp/' -e '/payment/ s/localhost/payment.devops.jcp/' /etc/nginx/default.d/roboshop.conf
STAT_CHECK $?

PRINT "Enabling Nginx\t\t"
systemctl enable nginx  &>>$LOG
STAT_CHECK $?

PRINT "Starting Nginx\t\t"
systemctl restart nginx  &>>$LOG
STAT_CHECK $?
