class AddDiverIdColumnToStatics < ActiveRecord::Migration
  def change
    add_column :statics, :diver_id, :integer
  end
end
