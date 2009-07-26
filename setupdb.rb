#!/usr/bin/env ruby

# http://www.tmtm.org/en/ruby/mysql/

require 'rubygems'
require 'mysql'

#CREATE USER
#CREATE DATABASE
#CREATE TABLE

=begin

 CREATE TABLE IF NOT EXISTS `feeds`(
	`id` INT PRIMARY KEY AUTO_INCREMENT,
	`feed` VARCHAR( 255 ) NOT NULL ,
	`lastupdated` INT NOT NULL,
	`interval` INT NOT NULL DEFAULT 60,
	UNIQUE (
	`feed`
	)
	);

=end