class AddPasswordDigestColumn < ActiveRecord::Migration
  def change
    add_column :divers, :password_digest, :string
  end
end
