class Channel < ActiveRecord::Base
  serialize :tags, Array

  def tweets
    Tweet.tagged_with(tags, any: true).order(created_at: 'DESC')
  end

  def recent_activity
    tweets.where('created_at > ?', Time.now - 1.days).size
  end
end
