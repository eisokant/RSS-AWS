#!/usr/bin/env ruby

require 'rubygems'
require 'right_aws'
require 'pp'

ENV['AMAZON_ACCESS_KEY_ID'] = '0NP33638CHYCXCYGKB82'
ENV['AMAZON_SECRET_ACCESS_KEY'] = 'uISvWmpU97xhMaqt5muEX4czYak19bjHay+IrHTZ'

sqs = RightAws::SqsGen2Interface.new(ENV['AMAZON_ACCESS_KEY_ID'], ENV['AMAZON_SECRET_ACCESS_KEY'])

qurl = sqs.queue_url_by_name('twollars_feeds')

sqs.send_message(qurl, 'http://techcrunch.com/wp-commentsrss2.php')
sqs.send_message(qurl, 'http://eisokant.com/wp-commentsrss2.php')
sqs.send_message(qurl, 'http://mashable.com/wp-commentsrss2.php')
sqs.send_message(qurl, 'http://politicalticker.blogs.cnn.com/wp-commentsrss2.php')
sqs.send_message(qurl, 'http://failblog.org/wp-commentsrss2.php')
sqs.send_message(qurl, 'http://coedmagazine.com/wp-commentsrss2.php')
sqs.send_message(qurl, 'http://celebrity-babies.com/wp-commentsrss2.php')
sqs.send_message(qurl, 'http://icanhascheezburger.com/wp-commentsrss2.php')
sqs.send_message(qurl, 'http://gretawire.foxnews.com/wp-commentsrss2.php')
sqs.send_message(qurl, 'http://2dopeboyz.com/wp-commentsrss2.php')
sqs.send_message(qurl, 'http://popseoul.com/wp-commentsrss2.php')
sqs.send_message(qurl, 'http://hackaday.com/wp-commentsrss2.php')
sqs.send_message(qurl, 'http://blogs.nfl.com/wp-commentsrss2.php')
sqs.send_message(qurl, 'http://blog.macleans.ca/wp-commentsrss2.php')
sqs.send_message(qurl, 'http://roflrazzi.com/wp-commentsrss2.php')
sqs.send_message(qurl, 'http://graphjam.com/wp-commentsrss2.php')
sqs.send_message(qurl, 'http://blogfama.wordpress.com/wp-commentsrss2.php')
sqs.send_message(qurl, 'http://punditkitchen.com/wp-commentsrss2.php')
sqs.send_message(qurl, 'http://ulloi129.wordpress.com/wp-commentsrss2.php')
sqs.send_message(qurl, 'http://educar.wordpress.com/wp-commentsrss2.php')
sqs.send_message(qurl, 'http://tvwatch.people.com/wp-commentsrss2.php')
sqs.send_message(qurl, 'http://ihasahotdog.com/wp-commentsrss2.php')
sqs.send_message(qurl, 'http://en.blog.wordpress.com/wp-commentsrss2.php')
sqs.send_message(qurl, 'http://engrishfunny.com/wp-commentsrss2.php')
sqs.send_message(qurl, 'http://foxforum.blogs.foxnews.com/wp-commentsrss2.php')
sqs.send_message(qurl, 'http://vinterstudion.wordpress.com/wp-commentsrss2.php')
sqs.send_message(qurl, 'http://wattsupwiththat.com/wp-commentsrss2.php')
sqs.send_message(qurl, 'http://yorkstrike2008.wordpress.com/wp-commentsrss2.php')
sqs.send_message(qurl, 'http://totallylookslike.com/wp-commentsrss2.php')
sqs.send_message(qurl, 'http://narcotijuana.info/wp-commentsrss2.php')
sqs.send_message(qurl, 'http://blog.flickr.net/wp-commentsrss2.php')
sqs.send_message(qurl, 'http://ronakorn.wordpress.com/wp-commentsrss2.php')
sqs.send_message(qurl, 'http://dizivizyon.wordpress.com/wp-commentsrss2.php')
sqs.send_message(qurl, 'http://cafedizi.wordpress.com/wp-commentsrss2.php')
sqs.send_message(qurl, 'http://ac360.blogs.cnn.com/wp-commentsrss2.php')
sqs.send_message(qurl, 'http://windowseven.wordpress.com/wp-commentsrss2.php')
sqs.send_message(qurl, 'http://nethaber.wordpress.com/wp-commentsrss2.php')
sqs.send_message(qurl, 'http://stylenews.peoplestylewatch.com/wp-commentsrss2.php')
sqs.send_message(qurl, 'http://bigbangkorean.wordpress.com/wp-commentsrss2.php')
sqs.send_message(qurl, 'http://blogdopaulinho.wordpress.com/wp-commentsrss2.php')
sqs.send_message(qurl, 'http://harismibrahim.wordpress.com/wp-commentsrss2.php')
sqs.send_message(qurl, 'http://pinkturtle2.wordpress.com/wp-commentsrss2.php')
sqs.send_message(qurl, 'http://foreman.blogs.topgear.com/wp-commentsrss2.php')
sqs.send_message(qurl, 'http://wordpress.tv/wp-commentsrss2.php')
sqs.send_message(qurl, 'http://scobleizer.com/wp-commentsrss2.php')
sqs.send_message(qurl, 'http://gigaom.com/wp-commentsrss2.php')
sqs.send_message(qurl, 'http://cincoelementos.wordpress.com/wp-commentsrss2.php')
sqs.send_message(qurl, 'http://antoniogenna.wordpress.com/wp-commentsrss2.php')
sqs.send_message(qurl, 'http://petsocietyitalia.wordpress.com/wp-commentsrss2.php')
sqs.send_message(qurl, 'http://riverdaughter.wordpress.com/wp-commentsrss2.php')
sqs.send_message(qurl, 'http://telemagia.wordpress.com/wp-commentsrss2.php')
sqs.send_message(qurl, 'http://thepage.time.com/wp-commentsrss2.php')
sqs.send_message(qurl, 'http://socioecohistory.wordpress.com/wp-commentsrss2.php')
sqs.send_message(qurl, 'http://missuniverse2008.wordpress.com/wp-commentsrss2.php')
sqs.send_message(qurl, 'http://unduetreblog.wordpress.com/wp-commentsrss2.php')
sqs.send_message(qurl, 'http://unreasonablefaith.com/wp-commentsrss2.php')
sqs.send_message(qurl, 'http://youngguns.wordpress.com/wp-commentsrss2.php')
sqs.send_message(qurl, 'http://orientacionandujar.wordpress.com/wp-commentsrss2.php')
sqs.send_message(qurl, 'http://strangemaps.wordpress.com/wp-commentsrss2.php')
sqs.send_message(qurl, 'http://audienciadatv.wordpress.com/wp-commentsrss2.php')
sqs.send_message(qurl, 'http://keyodemeleri.wordpress.com/wp-commentsrss2.php')
sqs.send_message(qurl, 'http://weeklyworldnews.com/wp-commentsrss2.php')
sqs.send_message(qurl, 'http://aksestan.wordpress.com/wp-commentsrss2.php')
sqs.send_message(qurl, 'http://clubpenguincheatscp.com/wp-commentsrss2.php')
sqs.send_message(qurl, 'http://sookyeong.wordpress.com/wp-commentsrss2.php')
sqs.send_message(qurl, 'http://cnnwire.blogs.cnn.com/wp-commentsrss2.php')
sqs.send_message(qurl, 'http://montrealaisorigine.wordpress.com/wp-commentsrss2.php')
sqs.send_message(qurl, 'http://sharingyoochun.wordpress.com/wp-commentsrss2.php')
sqs.send_message(qurl, 'http://blasfemias.net/wp-commentsrss2.php')
sqs.send_message(qurl, 'http://gellerentlarvt.wordpress.de/wp-commentsrss2.php')
sqs.send_message(qurl, 'http://stuffwhitepeoplelike.com/wp-commentsrss2.php')
sqs.send_message(qurl, 'http://frianyheter.wordpress.com/wp-commentsrss2.php')
sqs.send_message(qurl, 'http://swampland.blogs.time.com/wp-commentsrss2.php')
sqs.send_message(qurl, 'http://theappleblog.com/wp-commentsrss2.php')
sqs.send_message(qurl, 'http://babyrazzi.com/wp-commentsrss2.php')
sqs.send_message(qurl, 'http://curiosidadesnanet.wordpress.com/wp-commentsrss2.php')
sqs.send_message(qurl, 'http://sjsandteam.wordpress.com/wp-commentsrss2.php')
sqs.send_message(qurl, 'http://westham.wordpress.com/wp-commentsrss2.php')
sqs.send_message(qurl, 'http://bazarpop.wordpress.com/wp-commentsrss2.php')
sqs.send_message(qurl, 'http://endtimespropheticwords.wordpress.com/wp-commentsrss2.php')
sqs.send_message(qurl, 'http://onceuponawin.com/wp-commentsrss2.php')
sqs.send_message(qurl, 'http://palomitasymaiz.wordpress.com/wp-commentsrss2.php')
sqs.send_message(qurl, 'http://deepgoa.wordpress.com/wp-commentsrss2.php')
sqs.send_message(qurl, 'http://tennisplanet.wordpress.com/wp-commentsrss2.php')
sqs.send_message(qurl, 'http://htmlkodlarim.wordpress.com/wp-commentsrss2.php')
sqs.send_message(qurl, 'http://jkontherun.com/wp-commentsrss2.php')
sqs.send_message(qurl, 'http://kateharding.net/wp-commentsrss2.php')
sqs.send_message(qurl, 'http://deekmedia.wordpress.com/wp-commentsrss2.php')
sqs.send_message(qurl, 'http://clubpenguincp.com/wp-commentsrss2.php')
sqs.send_message(qurl, 'http://2009yerelsecimleri.wordpress.com/wp-commentsrss2.php')
sqs.send_message(qurl, 'http://superrobotwar.wordpress.com/wp-commentsrss2.php')
sqs.send_message(qurl, 'http://chid0ri.wordpress.com/wp-commentsrss2.php')
sqs.send_message(qurl, 'http://bloguebleuquebec.wordpress.com/wp-commentsrss2.php')
sqs.send_message(qurl, 'http://thai2entertainment.wordpress.com/wp-commentsrss2.php')
sqs.send_message(qurl, 'http://lottomania.wordpress.com/wp-commentsrss2.php')
sqs.send_message(qurl, 'http://amywelborn.wordpress.com/wp-commentsrss2.php')
sqs.send_message(qurl, 'http://gruphepsi.net/wp-commentsrss2.php')
sqs.send_message(qurl, 'http://boyslife.org/wp-commentsrss2.php')
sqs.send_message(qurl, 'http://zanquetta.wordpress.com/wp-commentsrss2.php')
sqs.send_message(qurl, 'http://ainuamri.wordpress.com/wp-commentsrss2.php')
sqs.send_message(qurl, 'http://technologizer.com/wp-commentsrss2.php')
sqs.send_message(qurl, 'http://subtitrari.wordpress.com/wp-commentsrss2.php')
sqs.send_message(qurl, 'http://completist.wordpress.com/wp-commentsrss2.php')
