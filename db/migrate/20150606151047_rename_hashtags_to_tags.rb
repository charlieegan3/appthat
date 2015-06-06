class RenameHashtagsToTags < ActiveRecord::Migration
  def change
    rename_column :tweets, :hashtags, :tags
  end
end
