#!/usr/bin/env ruby

require 'rubygems'
require 'mysql'

db = Mysql.new('localhost', 'twollars_feeds', 'GU149La8', 'twollars_feeds')

db.query("
        CREATE TABLE IF NOT EXISTS `feeds`(
        `id` INT PRIMARY KEY AUTO_INCREMENT,
        `feed` VARCHAR( 255 ) NOT NULL ,
        `lastupdated` INT NOT NULL,
        `interval` INT NOT NULL DEFAULT 60,
        UNIQUE (
        `feed`
        )
        );
")