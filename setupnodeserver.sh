#!/bin/bash

apt-get -y install curl libcurl3 libcurl3-gnutls libcurl4-openssl-dev

gem install uuidtools hpricot right_aws curb
gem install hungryblank-aws_sdb_bare eisokant-aws-s3 -s http://gems.github.com

