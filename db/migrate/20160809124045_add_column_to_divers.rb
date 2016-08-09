class AddColumnToDivers < ActiveRecord::Migration
  def change
    add_column :divers, :password, :string
  end
end
