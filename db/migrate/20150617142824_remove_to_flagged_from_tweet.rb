class RemoveToFlaggedFromTweet < ActiveRecord::Migration
  def change
    remove_column :tweets, :flagged, :bool
  end
end
