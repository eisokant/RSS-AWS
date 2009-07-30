#!/usr/bin/env ruby

require 'rubygems'
require 'daemons'

options = {
  :app_name   => "inserttask",
  :log_output => true,
  :monitor    => true
}

Daemons.run('inserttask.rb', options)