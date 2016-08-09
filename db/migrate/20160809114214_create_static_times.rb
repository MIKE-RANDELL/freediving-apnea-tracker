class CreateStaticTimes < ActiveRecord::Migration
  def change
    create_table :statics do |t|
      t.float :max_time
      t.string :overall_state
      t.timestamps
    end
  end
end
