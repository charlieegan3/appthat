class DefaultFlagsCountToZero < ActiveRecord::Migration
  def change
    change_column :tweets, :flags_count, :integer, default: 0
  end
end
