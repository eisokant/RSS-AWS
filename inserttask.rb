#!/usr/bin/env ruby

require 'rubygems'
require 'right_aws'
require 'mysql'
require 'pp'

ENV['AMAZON_ACCESS_KEY_ID'] = '0NP33638CHYCXCYGKB82'
ENV['AMAZON_SECRET_ACCESS_KEY'] = 'uISvWmpU97xhMaqt5muEX4czYak19bjHay+IrHTZ'

db = Mysql.new('localhost', 'twollars_feeds', 'GU149La8', 'twollars_feeds')

sqs = RightAws::SqsGen2Interface.new(ENV['AMAZON_ACCESS_KEY_ID'], ENV['AMAZON_SECRET_ACCESS_KEY'])

#sqs.create_queue('twollars_tasks')
qurl = sqs.queue_url_by_name('twollars_tasks')

loop do

  feeds = db.query("SELECT * FROM `feeds` WHERE `lastupdated` < (#{Time.now.to_i}-`interval`);")
  
  if feeds.num_rows == 0
    sleep(60)
  end

  feeds.each_hash { |row| 
    pp row
    sqs.send_message(qurl, row["feed"])
    db.query("UPDATE `feeds` SET `lastupdated`=#{Time.now.to_i} WHERE id=#{row["id"]};")
  }
end

