#!/bin/bash
 
# Install SQLite3 Engine
apt-get update
apt-get install sqlite3 libsqlite3-dev libsqlite3-ruby1.8

# Get and install latest SQLite3 Ruby Gem
wget http://rubyforge.org/frs/download.php/60923/sqlite3-ruby-1.2.5.gem
gem install sqlite3-ruby-1.2.5.gem

# Install daemons and Right AWS Ruby Gem - used for SQS
gem install right_aws daemons

# Create the database
touch ~/twollars_feeds.db

#ruby createtables.rb
#ruby inserttestdata.rb
#ruby insertfeed_control.rb start
#inserttask.rb start