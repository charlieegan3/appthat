class CreateChannels < ActiveRecord::Migration
  def change
    create_table :channels do |t|
      t.text :tags

      t.timestamps null: false
    end
  end
end
