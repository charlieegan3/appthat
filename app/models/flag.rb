class Flag < ActiveRecord::Base
  validates_uniqueness_of :ip, scope: :tweet_id
  belongs_to :tweet, counter_cache: true

  def self.set(tweet, ip)
    if (flags = where(tweet: tweet, ip: ip)).empty?
      create(tweet: tweet, ip: ip)
    else
      flags.delete_all
    end
  end
end
