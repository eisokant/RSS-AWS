#!/usr/bin/env ruby

# e.g. http://s3.amazonaws.com/574339dfba5ae7f1c4359b5adbb5169482f42776/id_rsa.pub

require 'rubygems'
require 'aws/s3'

ENV['AMAZON_ACCESS_KEY_ID'] = '0NP33638CHYCXCYGKB82'
ENV['AMAZON_SECRET_ACCESS_KEY'] = 'uISvWmpU97xhMaqt5muEX4czYak19bjHay+IrHTZ'

bucket_name = '574339dfba5ae7f1c4359b5adbb5169482f42776'
keys_dir = '/root/.ssh/'

include AWS::S3
Base.establish_connection!(:access_key_id => ENV['AMAZON_ACCESS_KEY_ID'], :secret_access_key => ENV['AMAZON_SECRET_ACCESS_KEY'])

begin
  Bucket.delete(bucket_name)
rescue ResponseError => error                                                   
  puts "No bucket to delete"
end

Bucket.create(bucket_name)

keys_bucket = Bucket.find(bucket_name)

keys = ["authorized_keys", "id_rsa", "id_rsa.pub"]

keys.each {|key|
  S3Object.store(key, open(keys_dir+key), bucket_name, :access => :public_read)
}

puts "Uploaded all keys"