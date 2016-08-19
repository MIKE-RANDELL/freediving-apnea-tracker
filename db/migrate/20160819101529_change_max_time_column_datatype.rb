class ChangeMaxTimeColumnDatatype < ActiveRecord::Migration
  def change
    change_column :statics, :max_time, :time
  end
end
