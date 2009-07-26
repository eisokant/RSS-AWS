#!/usr/bin/env ruby

require 'rubygems'
require 'right_aws'
require 'sqlite3'
require 'pp'

ENV['AMAZON_ACCESS_KEY_ID'] = '0NP33638CHYCXCYGKB82'
ENV['AMAZON_SECRET_ACCESS_KEY'] = 'uISvWmpU97xhMaqt5muEX4czYak19bjHay+IrHTZ'

db = SQLite3::Database.new('twollars_feeds.db')

sqs = RightAws::SqsGen2Interface.new(ENV['AMAZON_ACCESS_KEY_ID'], ENV['AMAZON_SECRET_ACCESS_KEY'])

qurl = sqs.queue_url_by_name('twollars_feeds')

loop do
  message = sqs.receive_message(qurl, 1, 30)
  if message.empty?
	sleep(60)
  else
	db.execute("INSERT IGNORE INTO `feeds` (`feed`, `lastupdated`) VALUES ('#{message[0]["Body"]}', #{Time.now.to_i});")
	sqs.delete_message(qurl, message[0]["ReceiptHandle"])
	puts "Handled: #{message[0]["Body"]} at #{Time.now}"
  end
end
