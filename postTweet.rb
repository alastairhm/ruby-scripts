# Post to Twitter
# Updated for new Twitter API

require "rubygems"
require "twitter" #https://github.com/sferik/twitter for config details

require File.expand_path(File.join(File.dirname(__FILE__), "twitterCode.rb"))
twitUser = "alastair_hm"

myTweet = Twitter::REST::Client.new do |config|
                config.consumer_key        = @twitterCodes[0]
                config.consumer_secret     = @twitterCodes[1]
                config.access_token        = @twitterCodes[2]
                config.access_token_secret = @twitterCodes[3]
            end

updateTweet = ARGV[0]
puts "Raw Tweet [#{updateTweet}]"
if updateTweet.length > 139 then
    updateTweet = updateTweet[0,139] + "..."
    puts "Was too long now [#{updateTweet}]"
end

# Update your status
puts "Posting..."
myTweet.update(updateTweet)
sleep(3)
puts myTweet.user_timeline(twitUser).first.text
