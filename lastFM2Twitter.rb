#
#  lastFM2Twitter.rb
#
#
#  Created by Alastair Montgomery on 21/07/2011.
#  Copyright (c) 2011 All rights reserved.
#

require "rubygems"
require "rss"
require "twitter"
require "pp"

class GetFeed
	attr_reader	:feed, :bytes

	def initialize(feedURL)
			rss_content = ""
			open(feedURL) { |f|
				rss_content = f.read
			}
			@bytes = rss_content.length
			@feed = RSS::Parser.parse(rss_content,false)
	end
end

class LastFM2Twitter
	attr_reader :myFeed, :myTweet, :music, :artists
	def initialize(feedURL,twitCode)
			@myFeed = GetFeed.new(feedURL)
			if $DEBUG then puts "Feed size #{@myFeed.feed.items.size}" end


			@myTweet = Twitter::REST::Client.new do |config|
      			config.consumer_key        = twitCode[0]
      			config.consumer_secret     = twitCode[1]
      			config.access_token        = twitCode[2]
      			config.access_token_secret = twitCode[3]
    		end
			@music = []
			@artists = []
			self.parseArtist
	end

	def parseArtist
		music = Array.new()
		artists = Array.new()
		@myFeed.feed.items.each { |item|
            #pp item
			artist = item.title.split("\u2013")[0].strip
			track = item.title.split("\u2013")[1].strip
			music << [artist,track,item.link]
			artists << artist
		}
		artists.uniq! if artists.uniq != nil
		artists.sort!
		@artists = Array.new(artists)
		@music = Array.new(music)
	end
end

codes = ["MUf7VkhxHAnqBPNXXHyUlA","1pVjdlGIm2IYLyIGcqiiViu6ip0BeGZnJjY0XxurY","14243786-yPwFlnfjMUH2TzmQbLFcIGZLXuxzWO2SYEHDt6fWg","5WQldW7sJGMyAeAUSW2ljjSMoab3V8yXfdLiSJp8X4E"]
myTest = LastFM2Twitter.new("http://ws.audioscrobbler.com/1.0/user/alastair_hm/recenttracks.rss",codes)

puts "Feed has #{myTest.myFeed.feed.items.size} items, with #{myTest.artists.length} artists."

puts "Tweet Updating"
msgText = "Listening 2 #{myTest.artists.join(", ")}"
puts "Message #{msgText.length} characters."
if msgText.length > 140 then
	msgText = msgText[0..139]
	msgText[137,139] = "..."
end
puts msgText

myTest.myTweet.update(msgText)
sleep (2)
puts myTest.myTweet.user_timeline("alastair_hm").first.text
