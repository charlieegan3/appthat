class Tweet < ActiveRecord::Base
  serialize :hashtags, Array
  validates_uniqueness_of :url
end
