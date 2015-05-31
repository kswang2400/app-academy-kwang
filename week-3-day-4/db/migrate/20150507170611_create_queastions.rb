class CreateQueastions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :text
      t.integer :poll_id
      t.timestamps
    end
  end
end
