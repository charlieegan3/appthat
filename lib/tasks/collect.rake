require_relative '../../config/environment'

def tags(tweet)
  OTS.parse(tweet.text)
    .keywords.map { |t| t.gsub(/\W+/, '') }
    .reject(&:empty?)
    .concat(tweet.hashtags)
    .map(&:downcase)
    .uniq
end

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

  tweets.select! { |t| t.text.downcase.match(/want|need|wish/) }
  tweets.reject! { |t| t.reply? || t.retweet? || t.media? || t.uris? || t.user_mentions? }
  tweets.reject! { |t| t.text.downcase.match(/don'?t need/) }
  tweets.reject! { |t| t.text.downcase.match(/there'?s?( is)? an app/) }
  tweets.reject! { |t| t.text.downcase.match(/if (you|u) need an app/) }
  tweets.reject! { |t| t.text.downcase.match(/(why|if)\w+need an/) }
  tweets.reject! { |t| t.text.match(/([A-Z]+ ?){2,}/) }
  tweets.reject! { |t| t.text.include?(' u ') }
  tweets.reject! { |t| t.text.downcase.include?('@') }
  tweets.reject! { |t| t.text.downcase.include?('if you need an app') }
  tweets.reject! { |t| t.text.downcase.include?('why would i') }
  tweets.reject! { |t| t.text.downcase.include?('on an app') }
  tweets.reject! { |t| t.text[0, 2] == 'RT' }

  tweets.each do |t|
    Tweet.create(url: t.url.to_s,
                 screen_name: t.user.screen_name,
                 text: t.text,
                 tags: tags(t))
  end
  puts "saved #{Tweet.count - exiting_count} tweets"
end
