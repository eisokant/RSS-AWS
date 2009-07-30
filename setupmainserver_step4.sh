#!/bin/bash

S3KEYSBUCKET="http://s3.amazonaws.com/574339dfba5ae7f1c4359b5adbb5169482f42776/"
SSHDIR="/root/.ssh/"
MAINDIR="/root/twollars/"
CLONEURL="git@github.com:eisokant/Twollars-AWS.git"

apt-get -y install git
apt-get -y install git-core

wget -P ${SSHDIR} ${S3KEYSBUCKET}authorized_keys
wget -P ${SSHDIR} ${S3KEYSBUCKET}id_rsa
wget -P ${SSHDIR} ${S3KEYSBUCKET}id_rsa.pub

git clone ${CLONEURL} ${MAINDIR}

ruby ${MAINDIR}createtables.rb
ruby ${MAINDIR}clearqueue.rb
ruby ${MAINDIR}inserttestdata.rb
ruby ${MAINDIR}insertfeed_control.rb stop
ruby ${MAINDIR}insertfeed_control.rb start
ruby ${MAINDIR}inserttask_control.rb stop
ruby ${MAINDIR}inserttask_control.rb start