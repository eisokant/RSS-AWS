#!/usr/bin/env ruby

require 'rubygems'
require 'aws_sdb_bare'
require 'uuidtools'
require 'hpricot'
require 'pp'
require 'open-uri'
require 'right_aws'

ENV['AMAZON_ACCESS_KEY_ID'] = '0NP33638CHYCXCYGKB82'
ENV['AMAZON_SECRET_ACCESS_KEY'] = 'uISvWmpU97xhMaqt5muEX4czYak19bjHay+IrHTZ'

domain = 'twollars_feeds'

sqs = RightAws::SqsGen2.new(ENV['AMAZON_ACCESS_KEY_ID'], ENV['AMAZON_SECRET_ACCESS_KEY'])

#queue1 = sqs.queue('twollars_feeds')
queue2 = RightAws::SqsGen2::Queue.create(sqs, 'twollars_feeds', true)

#queue2.clear(true)
queue2.send_message('http://www.techcrunch.com/wp-commentsrss2.php')
#message2 = queue2.pop

message1 = queue2.receive
message1.visibility = 0
puts message1

Process.exit

feeds = ['http://www.techcrunch.com/wp-commentsrss2.php', 'http://www.eisokant.com/wp-commentsrss2.php', 'http://www.mashable.com/wp-commentsrss2.php']

include AwsSdb
include AwsSdb::Request

# start :: Deletes and then creates the domain - easy for testing purposes
request = DeleteDomain.new(:name => domain)
open(request.uri)

request = CreateDomain.new(:name => domain)
open(request.uri)
# end

request = ListDomains.new
response = AwsSdb::Response.parse(open(request.uri))
pp response.domains

feeds.each do |feed|
   
   h_item = Hash.new
   
   key = UUIDTools::UUID.sha1_create(UUIDTools::UUID_DNS_NAMESPACE, feed).to_s
      
   h_item["source"] = {:value => feed, :replace => true}
   h_item["timestamp"] = {:value => Time.now.to_i, :replace => true}
   h_item["interval"] = {:value => 180, :replace => true}
      
   request = PutAttributes.new(:domain => domain, :name => key)
   request.attributes = h_item
   open(request.uri)   
end

techcrunch = UUIDTools::UUID.sha1_create(UUIDTools::UUID_DNS_NAMESPACE, 'http://www.techcrunch.com/wp-commentsrss2.php')

request = Select.new(:query => "SELECT * FROM #{domain} LIMIT 2") #GetAttributes.new(:domain => domain, :name => techcrunch)
response = Response.parse(open(request.uri))
pp response

