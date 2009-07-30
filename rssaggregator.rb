#!/usr/bin/env ruby

=begin
read: http://github.com/hungryblank/aws_sdb_bare
read: http://amazon.rubyforge.org/
read: http://wiki.github.com/why/hpricot/hpricot-xml
sudo gem install uuidtools aws-s3 open-uri hpricot right_aws 
sudo gem install hungryblank-aws_sdb_bare -s http://gems.github.com
=end

require 'rubygems'
require 'aws_sdb_bare'
require 'aws/s3'
require 'uuidtools'
require 'hpricot'
require 'pp'
require 'open-uri'
require 'right_aws'

ENV['AMAZON_ACCESS_KEY_ID'] = '0NP33638CHYCXCYGKB82'
ENV['AMAZON_SECRET_ACCESS_KEY'] = 'uISvWmpU97xhMaqt5muEX4czYak19bjHay+IrHTZ'

domain = 'twollars_rss_data'
bucket_name = 'twollars_rss_data'

include AwsSdb
include AwsSdb::Request
include AWS::S3

Base.establish_connection!(:access_key_id => ENV['AMAZON_ACCESS_KEY_ID'], :secret_access_key => ENV['AMAZON_SECRET_ACCESS_KEY'])
twollars_bucket = Bucket.find(bucket_name)

sqs = RightAws::SqsGen2Interface.new(ENV['AMAZON_ACCESS_KEY_ID'], ENV['AMAZON_SECRET_ACCESS_KEY'])

qurl = sqs.queue_url_by_name('twollars_tasks')

loop do
  message = sqs.receive_message(qurl, 1, 180)
  if message.empty?
	sleep(60)
  else
	rss_feed = message[0]["Body"]#"http://www.techcrunch.com/comments/feed/"

	content = Hpricot.XML(open(rss_feed))
	count = 0
	parsed = Hash.new

	(content/:item).each do |item| 
	 
	  h_item = Hash.new
	   
	  guid = (item/:guid).inner_html
	  description = (item/:description).inner_html   
	  key_string = rss_feed + guid
	   
	  key = UUIDTools::UUID.sha1_create(UUIDTools::UUID_DNS_NAMESPACE, key_string).to_s
	  item_name = UUIDTools::UUID.sha1_create(UUIDTools::UUID_DNS_NAMESPACE, guid).to_s
	   
	  S3Object.store(key, description, bucket_name, :access => :public_read)
	   
	  item.containers.each do |node|	
		if node.name == 'description'
		  h_item[node.name] = {:value => key, :replace => true}
		else
		  h_item[node.name]= {:value => node.inner_html, :replace => true}
		end
	  end 
		  
	  h_item["rss_source"] = {:value => rss_feed, :replace => true}
	   
	  request = PutAttributes.new(:domain => domain, :name => item_name)
	  request.attributes = h_item
	  open(request.uri)
	  
	  parsed[count] = h_item
	  count = count +1   
	end
	sqs.delete_message(qurl, message[0]["ReceiptHandle"])
  end
end