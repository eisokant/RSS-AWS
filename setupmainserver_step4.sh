#!/bin/bash

apt-get -y install git
apt-get -y install git-core

wget http://.com/authorized_keys
wget http://.com/id_rsa
wget http://.com/id_rsa.pub

mv authorized_keys /root/.ssh/authorized_keys
mv id_rsa /root/.ssh/id_rsa
mv id_ra.pub /root/.ssh/id_rsa.pub

MAINDIR = "/root/twollars/"

git clone git@github.com:eisokant/Twollars-AWS.git ${MAINDIR}

ruby ${MAINDIR}createtables.rb
ruby ${MAINDIR}clearqueue.rb
ruby ${MAINDIR}inserttestdata.rb
ruby ${MAINDIR}insertfeed_control.rb stop
ruby ${MAINDIR}insertfeed_control.rb start
ruby ${MAINDIR}inserttask_control.rb stop
ruby ${MAINDIR}inserttask_control.rb start