class ChangeDynamicMaxTimeColumnToMaxDistance < ActiveRecord::Migration
  def change
    rename_column :dynamics, :max_time, :max_distance
  end
end
