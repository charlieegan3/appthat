class AddToFlagToTweets < ActiveRecord::Migration
  def change
    add_column :tweets, :to_flag, :boolean
  end
end
