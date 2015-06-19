class AddFlagsCountToTweets < ActiveRecord::Migration
  def change
    add_column :tweets, :flags_count, :integer
  end
end
