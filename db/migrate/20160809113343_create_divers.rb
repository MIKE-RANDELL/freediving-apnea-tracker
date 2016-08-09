class CreateDivers < ActiveRecord::Migration
  def change
    create_table :divers do |t|
      t.string :name
      t.integer :experience
    end
  end
end
