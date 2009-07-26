#!/usr/bin/env ruby

require 'rubygems'
require 'right_aws'
require 'pp'

ENV['AMAZON_ACCESS_KEY_ID'] = '0NP33638CHYCXCYGKB82'
ENV['AMAZON_SECRET_ACCESS_KEY'] = 'uISvWmpU97xhMaqt5muEX4czYak19bjHay+IrHTZ'

sqs = RightAws::SqsGen2Interface.new(ENV['AMAZON_ACCESS_KEY_ID'], ENV['AMAZON_SECRET_ACCESS_KEY'])

qurl = sqs.queue_url_by_name('twollars_feeds')

sqs.send_message(qurl, 'http://techcrunch.com/wp-commentsrss2.php')
sqs.send_message(qurl, 'http://eisokant.com/wp-commentsrss2.php')
sqs.send_message(qurl, 'http://mashable.com/wp-commentsrss2.php')