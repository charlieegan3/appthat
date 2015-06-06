class Tweet < ActiveRecord::Base
  serialize :tags, Array
  validates_uniqueness_of :url
  validates_uniqueness_of :text
end
