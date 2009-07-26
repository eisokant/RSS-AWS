#!/usr/bin/env ruby

=begin
read: http://github.com/hungryblank/aws_sdb_bare
read: http://amazon.rubyforge.org/
read: http://wiki.github.com/why/hpricot/hpricot-xml
sudo gem install uuidtools aws-s3 open-uri hpricot 
sudo gem install hungryblank-aws_sdb_bare -s http://gems.github.com
=end

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

=begin
#Bucket.delete(bucket_name, :force => true)
#Bucket.create(bucket_name)
#pp Service.buckets

# start :: Deletes and then creates the domain - easy for testing purposes
request = DeleteDomain.new(:name => domain)
open(request.uri)

request = CreateDomain.new(:name => domain)
open(request.uri)
# end

request = ListDomains.new
response = AwsSdb::Response.parse(open(request.uri))
pp response.domains

def djbhash( str, len=str.length )
  hash = 5381
  len.times{ |i|
    hash = ((hash << 5) + hash) + str[i]
  }
  return hash
end
=end

rss_feed = "http://www.techcrunch.com/comments/feed/"

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



=begin
request = GetAttributes.new(:domain => domain, :name => UUIDTools::UUID.sha1_create(UUIDTools::UUID_DNS_NAMESPACE, 'http://www.techcrunch.com/?p=86584#comment-2878296'))
response = Response.parse(open(request.uri))
#pp response
pp response.attributes
#puts response.attributes["title"]
=end