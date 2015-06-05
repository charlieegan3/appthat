require_relative '../../config/environment'

task :collect do
  exiting_count = Tweet.count

  client = Twitter::REST::Client.new do |config|
    config.consumer_key        = ENV['CONSUMER_KEY']
    config.consumer_secret     = ENV['CONSUMER_SECRET']
    config.access_token        = ENV['ACCESS_TOKEN']
    config.access_token_secret = ENV['ACCESS_TOKEN_SECRET']
  end

  tweets = client.search('"an app that"', result_type: "recent").take(15)
  tweets += client.search('"an app to"', result_type: "recent").take(15)
  tweets += client.search('"an app for"', result_type: "recent").take(15)

  tweets.reject! { |t| t.reply? || t.retweet? || t.media? || t.uris? || t.user_mentions? }
  tweets.reject! { |t| t.text.match(/don'?t need/) }
  tweets.select! { |t| t.text.match(/want|need|wish/) }

  tweets.each do |t|
    Tweet.create(url: t.url.to_s,
                 screen_name: t.user.screen_name,
                 text: t.text,
                 hashtags: t.hashtags.map {|x|x.text})
  end
  puts "saved #{Tweet.count - exiting_count} tweets"
end
