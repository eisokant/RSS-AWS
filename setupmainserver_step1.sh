#!/bin/bash
apt-get -y update
apt-get -y install expect

VAR=$(expect -c "
spawn apt-get -y install mysql-server
expect "New password for the MySQL \"root\" user:"
send "GU149La8\r"
expect "Repeat password for the MySQL \"root\" user:"
send "GU149La8\r"
expect eof
")

echo "$VAR"

apt-get -y install mysql-client libmysqlclient15-dev
 
apt-get -y install libmysql-ruby1.8 

/etc/init.d/mysql stop
/etc/init.d/mysql start
 
# Install MySQL, Daemons and Right AWS Ruby Gem used for SQS
gem install right_aws daemons

# http://jetpackweb.com/blog/2009/07/20/bash-script-to-create-mysql-database-and-user
MYSQL=`which mysql`
 
Q1="CREATE DATABASE IF NOT EXISTS twollars_feeds;"
Q2="GRANT ALL ON *.* TO 'twollars_feeds'@'localhost' IDENTIFIED BY 'GU149La8';"
Q3="FLUSH PRIVILEGES;"
SQL="${Q1}${Q2}${Q3}"

$MYSQL -uroot -p -e "$SQL"

ruby createtables.rb
ruby clearqueue.rb
ruby inserttestdata.rb
ruby insertfeed_control.rb start
ruby inserttask_control.rb start