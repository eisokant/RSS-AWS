#!/bin/bash

apt-get -y install git

wget http://.com/authorized_keys
wget http://.com/id_rsa
wget http://.com/id_rsa.pub

mv authorized_keys /root/.ssh/authorized_keys
mv id_rsa /root/.ssh/id_rsa
mv id_ra.pub /root/.ssh/id_rsa.pub

ruby createtables.rb
ruby clearqueue.rb
ruby inserttestdata.rb
ruby insertfeed_control.rb start
ruby inserttask_control.rb start