require 'twitter'
require 'time'
require 'redis'
require 'uri'

begin
  uri = URI.parse(ENV["REDISTOGO_URL"])
  REDIS = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)
rescue
  puts "Redis rescue: #{$!}"
  REDIS = Redis.new
end

Twitter.configure do |config|
  config.consumer_key = ENV['TWITTER_CONSUMER_KEY']
  config.consumer_secret = ENV['TWITTER_CONSUMER_SECRET']
  config.oauth_token = ENV['TWITTER_OAUTH_TOKEN']
  config.oauth_token_secret = ENV['TWITTER_OAUTH_TOKEN_SECRET']
end

trolling_list = [
  'Me? :(',
  'Hey! :(',
  "That's so sad... snif",
  'Hello!',
  'Hi! :(',
  'Hey there!!',
  'Snif, snif, snif, snif...',
  'So alone, snif :(',
  "So let's get together..."
]

client = Twitter::Client.new
task :default do
  timestamp = Time.at((REDIS.get('lasttime') || Time.now).to_i)
  trolling_list = trolling_list.shuffle

  ["forever alone"].each do |phrase|
    Twitter.search(phrase, :count => 20, :result_type => "recent").results.each do |tweet|
      puts tweet.inspect
      next if tweet.text[0..0] == "@"
      trolling_message = trolling_list.pop
      if tweet.created_at > timestamp
        puts "@#{tweet.from_user} #{trolling_message}".inspect
        client.update("@#{tweet.from_user} #{trolling_message}")
      end
      trolling_list = [trolling_message] + trolling_list
    end
  end

  REDIS.set('lasttime', Time.now.to_i)
end
