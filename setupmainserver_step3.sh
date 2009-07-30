#!/bin/bash

apt-get -y install mysql-client libmysqlclient15-dev
 
apt-get -y install libmysql-ruby1.8 
 
# Install MySQL, Daemons and Right AWS Ruby Gem used for SQS
gem install right_aws daemons

# http://jetpackweb.com/blog/2009/07/20/bash-script-to-create-mysql-database-and-user
MYSQL=`which mysql`
 
Q1="CREATE DATABASE IF NOT EXISTS twollars_feeds;"
Q2="GRANT ALL ON *.* TO 'twollars_feeds'@'localhost' IDENTIFIED BY 'GU149La8';"
Q3="FLUSH PRIVILEGES;"
SQL="${Q1}${Q2}${Q3}"

$MYSQL -uroot -pGU149La8 -e "$SQL"

ruby createtables.rb
ruby clearqueue.rb
ruby inserttestdata.rb
ruby insertfeed_control.rb start
ruby inserttask_control.rb start