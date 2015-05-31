class CreateTagTopics < ActiveRecord::Migration
  def change
    create_table :tag_topics do |t|
      t.string :topic

      t.timestamp
    end

    add_index :tag_topics, :topic
  end
end
