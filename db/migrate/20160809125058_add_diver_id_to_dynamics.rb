class AddDiverIdToDynamics < ActiveRecord::Migration
  def change
    add_column :dynamics, :diver_id, :integer
  end
end
