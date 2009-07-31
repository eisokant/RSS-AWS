#!/usr/bin/env ruby

=begin 
read: http://github.com/hungryblank/aws_sdb_bare 
read: http://amazon.rubyforge.org/ 
read: http://wiki.github.com/why/hpricot/hpricot-xml sudo 
gem install uuidtools open-uri hpricot right_aws curb
sudo gem install hungryblank-aws_sdb_bare eisokant-aws-s3 -s http://gems.github.com 
S3 Comment Storage
#http://twollars-rss-data.s3.amazonservices.com/be7ae9cf-98d8-50a3-8e78-2de58fcb9937
To enable it with post feeds I can code:
 - create another S3 bucket
 - and store content:encoded
=end 

require 'rubygems' 
require 'aws_sdb_bare' 
require 'aws/s3' 
require 'uuidtools' 
require 'hpricot' 
require 'pp' 
require 'open-uri' 
require 'right_aws' 
require 'curb'
require 'thread'

SEMAPHORE = Mutex.new

ENV['AMAZON_ACCESS_KEY_ID'] = '0NP33638CHYCXCYGKB82' 
ENV['AMAZON_SECRET_ACCESS_KEY'] = 'uISvWmpU97xhMaqt5muEX4czYak19bjHay+IrHTZ' 

domain = 'twollars-rss-data' 
bucket_name = 'twollars-rss-data' 

include AwsSdb 
include AwsSdb::Request 
include AWS::S3 

begin
  request = CreateDomain.new({:name => domain})
  Curl::Easy.perform(request.uri)                                     
rescue => e
  pp e 
end
          
Base.establish_connection!(:access_key_id => ENV['AMAZON_ACCESS_KEY_ID'], :secret_access_key => ENV['AMAZON_SECRET_ACCESS_KEY']) 

begin
  twollars_bucket = Bucket.find(bucket_name) 
rescue ResponseError => error
  twollars_bucket = Bucket.create(bucket_name) 
end 

sqs = RightAws::SqsGen2Interface.new(ENV['AMAZON_ACCESS_KEY_ID'], ENV['AMAZON_SECRET_ACCESS_KEY']) 
qurl = sqs.queue_url_by_name('twollars_tasks')

#pp sqs.get_queue_length(qurl)

loop do
 
  messages = Array.new
  100.times do
    message = sqs.receive_message(qurl, 1, 180)
    if message.empty?
      break
    end
    messages << message
  end

  count =0
  feedmsgs = Hash.new
  feedsraw = Array.new

  total = messages.inject([]) { |result,h|

  if not result.include?(h[0]["Body"])    
    result << h[0]["Body"]
    feedsraw[count] = h    
    resultx = Hash.new   
    resultx["Body"] = h[0]["Body"]     
    resultx["ReceiptHandle"] = h[0]["ReceiptHandle"]  
    feedmsgs[count] = resultx
    count = count+1
  end  
  result
  }    
  
  duplicates = messages-feedsraw
  
  puts messages.length
  puts feedmsgs.length  
  puts duplicates.length

  if feedmsgs.empty?
    sleep(60)
  end
  
  threads_feeds = []
  
  feedmsgs.each{|message|

    threads_feeds << Thread.new(message[1]) { |msg|
       
      rss_feed = msg["Body"]#"http://www.techcrunch.com/comments/feed/"
      puts "Time: #{Time.now} - starting: #{rss_feed}"

      begin                                                                         
        c = Curl::Easy.new(rss_feed) do |curl|                                
          #curl.headers["User-Agent"] = "myapp-0.0"                           
          curl.follow_location = true       
          curl.connect_timeout = 15  		  
        end                                                                                                                                   
        c.perform
        feed_file = c.body_str
      rescue => e
        pp e
        Thread.exit
	  end

      content = Hpricot.XML(feed_file)
      count = 0
      parsed = Hash.new
      (content/:item).each do |item|
         
        h_item = Hash.new
           
        guid = (item/:guid).inner_html
        description = (item/:description).inner_html
        key_string = rss_feed + guid
         
        key = UUIDTools::UUID.sha1_create(UUIDTools::UUID_DNS_NAMESPACE, key_string).to_s
        item_name = UUIDTools::UUID.sha1_create(UUIDTools::UUID_DNS_NAMESPACE, guid).to_s

        #http://www.blik.it/2008/5/15/aws-s3-eoferror-sysread-error-and-ruby-threads
        S3Object.store(key, description, bucket_name, :access => :public_read)
         
        item.containers.each do |node|
          if node.name == 'description'
            h_item[node.name] = {:value => key, :replace => true}
          else
            h_item[node.name]= {:value => node.inner_html.slice(0, 1024), :replace => true}
          end
        end
                  
        h_item["rss_source"] = {:value => rss_feed, :replace => true}
           
        request = PutAttributes.new(:domain => domain, :name => item_name)
        request.attributes = h_item
          
        begin                                                                 
          Curl::Easy.perform(request.uri)                                     
        rescue => e                                                           
          pp e                                                                
        end      

        parsed[count] = h_item
        count = count +1

      end
      sqs.delete_message(qurl, msg["ReceiptHandle"])
	  puts "Completed #{Time.now} - #{rss_feed}"
	}
  }
  threads_feeds.each { |aThread|  aThread.join }
  
  duplicates.each{|dup|
    sqs.delete_message(qurl, dup[0]["ReceiptHandle"])
  }
  
end
