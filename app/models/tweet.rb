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

  def self.search(tags)
    tagged_with(tags)
      .select(:id, :url, :screen_name, :text, :created_at)
      .limit(100)
      .order(created_at: 'DESC')
  end

  def self.unchanneled
    unflagged.tagged_with(Channel.all.pluck(:tags).reduce(:+), exclude: true).order(created_at: 'DESC')
  end

  def self.latest
    unflagged.where('created_at > ?', Time.now - 1.days).order(created_at: 'DESC')
  end

  def self.unflagged
    where('flags_count IS NULL or flags_count < 2')
  end

  def self.flagged
    where('flags_count > 2')
  end
end
