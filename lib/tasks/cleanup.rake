require_relative '../../config/environment'

task :clean do
  Tweet.where('created_at < ?', 1.month.ago).each do |tweet|
    puts tweet.text
    tweet.destroy
  end
end
