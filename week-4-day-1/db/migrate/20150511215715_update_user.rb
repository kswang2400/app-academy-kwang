class UpdateUser < ActiveRecord::Migration
  def change
    remove_column :users, :name
    rename_column :users, :email, :username
  end
end
