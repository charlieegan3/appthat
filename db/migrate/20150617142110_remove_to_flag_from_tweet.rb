class RemoveToFlagFromTweet < ActiveRecord::Migration
  def change
    remove_column :tweets, :to_flag, :bool
  end
end
