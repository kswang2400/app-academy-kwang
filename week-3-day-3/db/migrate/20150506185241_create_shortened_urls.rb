class CreateShortenedUrls < ActiveRecord::Migration
  def change
    create_table :shortened_urls do |t|
      t.string :short_url
      t.string :long_url
      t.integer :submitter_id

      t.timestamps
    end

    add_index :shortened_urls, :short_url, unique: true
    add_index :shortened_urls, :submitter_id
  end
end
