#!/usr/bin/env ruby

require 'rubygems'
require 'right_aws'
require 'mysql'
require 'pp'

ENV['AMAZON_ACCESS_KEY_ID'] = '0NP33638CHYCXCYGKB82'
ENV['AMAZON_SECRET_ACCESS_KEY'] = 'uISvWmpU97xhMaqt5muEX4czYak19bjHay+IrHTZ'

db = Mysql.new('localhost', 'twollars_feeds', 'GU149La8', 'twollars_feeds')

sqs = RightAws::SqsGen2Interface.new(ENV['AMAZON_ACCESS_KEY_ID'], ENV['AMAZON_SECRET_ACCESS_KEY'])

qurl = sqs.queue_url_by_name('twollars_feeds')

loop do
  message = sqs.receive_message(qurl, 1, 30)
  if message.empty?
	sleep(60)
  else
	db.query("INSERT IGNORE INTO `feeds` (`feed`, `lastupdated`) VALUES ('#{message[0]["Body"]}', #{Time.now.to_i});")
	sqs.delete_message(qurl, message[0]["ReceiptHandle"])
	puts "Handled: #{message[0]["Body"]} at #{Time.now}"
  end
end
