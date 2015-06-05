class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.string :url
      t.string :screen_name
      t.string :text
      t.string :hashtags

      t.timestamps null: false
    end
  end
end
