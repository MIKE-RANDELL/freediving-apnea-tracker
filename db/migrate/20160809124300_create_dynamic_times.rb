class CreateDynamicTimes < ActiveRecord::Migration
  def change
    create_table :dynamics do |t|
      t.float :max_time
      t.string :overall_state
      t.timestamps
    end
  end
end
