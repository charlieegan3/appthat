class CreateFlags < ActiveRecord::Migration
  def change
    create_table :flags do |t|
      t.string :ip
      t.references :tweet, index: true

      t.timestamps null: false
    end
    add_foreign_key :flags, :tweets
  end
end
