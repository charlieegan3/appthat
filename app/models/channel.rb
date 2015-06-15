class Channel < ActiveRecord::Base
  serialize :tags, Array

  def latest
    Tweet.tagged_with(tags, any: true).order(created_at: 'DESC')
  end
end
