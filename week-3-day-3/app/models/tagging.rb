# == Schema Information
#
# Table name: taggings
#
#  id          :integer          not null, primary key
#  tagtopic_id :integer
#  url_id      :integer
#  created_at  :datetime
#  updated_at  :datetime
#


class Tagging < ActiveRecord::Base
  validates :tagtopic_id, :url_id, presence: true

  belongs_to(
    :tagtopic,
    class_name: "TagTopic",
    foreign_key: :tagtopic_id,
    primary_key: :id
  )

  belongs_to(
    :url,
    class_name: "ShortenedUrl",
    foreign_key: :url_id,
    primary_key: :id
  )

  def self.create_new_tag!(url, tag)
    Tagging.create!(url_id: url.id, tagtopic_id: tag.id)
  end
end
