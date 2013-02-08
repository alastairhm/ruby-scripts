# Find your Twitter Mentions

require "rubygems"
require "twitter" #https://github.com/sferik/twitter for config details

Twitter.mentions_timeline.each { |tweet|
    puts "#{tweet.user.screen_name}, #{tweet.text}"
    puts
}
