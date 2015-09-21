class Channel < ActiveRecord::Base
  serialize :tags, Array

  def tweets
    Tweet.unflagged
      .tagged_with(tags, any: true)
      .limit(100)
      .order(created_at: 'DESC')
  end

  def recent_activity
    tweets.where('created_at > ?', Time.now - 1.days).size
  end
end
