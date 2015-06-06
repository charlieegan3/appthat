class AddFlaggedToTweet < ActiveRecord::Migration
  def change
    add_column :tweets, :flagged, :boolean
  end
end
