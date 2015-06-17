class Tweet < ActiveRecord::Base
  has_many :flags

  acts_as_taggable

  serialize :tags, Array
  validates_uniqueness_of :url
  validates_uniqueness_of :text

  before_create :prevent_duplicates

  def prevent_duplicates
    Tweet.where('created_at >= ?', Time.zone.now - 7.days).each do |t|
      if Jaccard.coefficient(clean_text, t.clean_text) > 0.8
        fail 'ItemTooSimilar'
      end
    end
  end

  def clean_text
    text.downcase.gsub(/[^ \w]/, '').split()
  end

  def self.unchanneled
    tagged_with(Channel.all.pluck(:tags).reduce(:+), exclude: true).order(created_at: 'DESC')
  end

  def self.latest
    where('created_at > ?', Time.now - 1.days).order(created_at: 'DESC')
  end
end
