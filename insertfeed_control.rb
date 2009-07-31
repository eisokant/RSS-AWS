#!/usr/bin/env ruby

require 'rubygems'
require 'daemons'

options = {
  :app_name   => "insertfeed",
  :log_output => true,
  :monitor    => true
}

Daemons.run('/root/twollars/insertfeed.rb', options)