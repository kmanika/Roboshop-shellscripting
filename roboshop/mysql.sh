#!/bin/bash

source common.sh

PRINT "Setup MySQL Repos"
echo '[mysql57-community]
name=MySQL 5.7 Community Server
baseurl=http://repo.mysql.com/yum/mysql-5.7-community/el/7/$basearch/
enabled=1
gpgcheck=0' > /etc/yum.repos.d/mysql.repo
STAT_CHECK $?


PRINT "Install MySQL"
yum install mysql-community-server -y &>>$LOG
STAT_CHECK $?

PRINT "Start MySQL Service"
systemctl enable mysqld &>>$LOG  && systemctl start mysqld &>>$LOG
STAT_CHECK $?

PRINT "Reset MySQL Root Password"
DEFAULT_PASSWORD=$(grep 'A temporary password' /var/log/mysqld.log  | awk '{print $NF}')
echo "show databases;" | mysql -uroot -pRoboShop@1 &>>$LOG
if [ $? -ne 0 ]; then
  echo "ALTER USER 'root'@'localhost' IDENTIFIED BY 'RoboShop@1';" | mysql --connect-expired-password -uroot -p${DEFAULT_PASSWORD} &>>$LOG
fi
STAT_CHECK $?

#
#Next, We need to change the default root password in order to start using the database service.
## mysql_secure_installation
#
#You can check the new password working or not using the following command.
#
## mysql -u root -p
#
#Run the following SQL commands to remove the password policy.
#> uninstall plugin validate_password;
#Setup Needed for Application.
#As per the architecture diagram, MySQL is needed by
#
#Shipping Service
#So we need to load that schema into the database, So those applications will detect them and run accordingly.
#
#To download schema, Use the following command
#
## curl -s -L -o /tmp/mysql.zip "https://github.com/roboshop-devops-project/mysql/archive/main.zip"
#Load the schema for Services.
#
## cd /tmp
## unzip mysql.zip
## cd mysql-main
## mysql -uroot -pRoboShop@1 <shipping.sql