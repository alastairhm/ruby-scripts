# Find your Twitter Mentions
# Updated for new Twitter API

require "rubygems"
require "twitter" #https://github.com/sferik/twitter for config details

require File.expand_path(File.join(File.dirname(__FILE__), "twitterCode.rb"))

myTweet = Twitter::REST::Client.new do |config|
                config.consumer_key        = @twitterCodes[0]
                config.consumer_secret     = @twitterCodes[1]
                config.access_token        = @twitterCodes[2]
                config.access_token_secret = @twitterCodes[3]
            end

myTweet.mentions_timeline.each { |tweet|
    puts "#{tweet.user.screen_name}, #{tweet.text}"
    puts
}
