#!/usr/bin/env ruby

require 'rubygems'
require 'right_aws'
require 'sqlite3'
require 'pp'

ENV['AMAZON_ACCESS_KEY_ID'] = '0NP33638CHYCXCYGKB82'
ENV['AMAZON_SECRET_ACCESS_KEY'] = 'uISvWmpU97xhMaqt5muEX4czYak19bjHay+IrHTZ'

db = SQLite3::Database.new('twollars_feeds.db')

sqs = RightAws::SqsGen2Interface.new(ENV['AMAZON_ACCESS_KEY_ID'], ENV['AMAZON_SECRET_ACCESS_KEY'])

#sqs.create_queue('twollars_tasks')
qurl = sqs.queue_url_by_name('twollars_tasks')

stmt = db.prepare("SELECT * FROM `feeds` WHERE `lastupdated` < (#{Time.now.to_i}-`interval`);")
stmt.execute do |result|
  pp result[0]
  #sqs.send_message(qurl, 'http://eisokant.com/wpcommentsrss.php')
end

