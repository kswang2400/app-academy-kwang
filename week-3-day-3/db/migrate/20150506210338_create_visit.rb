
class CreateVisit < ActiveRecord::Migration
  def change
    create_table :visits do |t|
      t.integer :user_id
      t.integer :url_id

      t.timestamps
    end

    add_index :visits, :user_id
    add_index :visits, :url_id
  end
end
