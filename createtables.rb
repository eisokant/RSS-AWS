#!/usr/bin/env ruby

require 'rubygems'
require 'sqlite3'

db = SQLite3::Database.new('twollars_feeds.db')

db.execute("
        CREATE TABLE IF NOT EXISTS `feeds`(
        `id` INTEGER PRIMARY KEY ,
        `feed` VARCHAR( 255 ) NOT NULL ,
        `lastupdated` INTEGER NOT NULL,
        `interval` INTEGER NOT NULL DEFAULT 60,
        UNIQUE (
        `feed`
        )
        );
")