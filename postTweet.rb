# Post to Twitter

require "rubygems"
require "twitter" #https://github.com/sferik/twitter for config details

updateTweet = ARGV[0]
puts "Raw Tweet [#{updateTweet}]"
if updateTweet.length > 139 then
    updateTweet = updateTweet[0,139] + "..."
    puts "Was too long now [#{updateTweet}]"
end

# Update your status
puts "Posting..."
#Twitter.update(updateTweet)
sleep(3)

puts Twitter.user_timeline("alastair_hm").first.text
