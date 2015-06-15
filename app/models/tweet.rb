class Tweet < ActiveRecord::Base
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

  def is_flagged?
    if self.flagged.nil?
      return false
    else
      return self.flagged
    end
  end
end
