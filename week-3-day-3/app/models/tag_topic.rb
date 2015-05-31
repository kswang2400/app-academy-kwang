# == Schema Information
#
# Table name: tag_topics
#
#  id    :integer          not null, primary key
#  topic :string
#


class TagTopic < ActiveRecord::Base
  validates :topic, presence: true

  has_many(
    :taggings,
    class_name: "Tagging",
    foreign_key: :tagtopic_id,
    primary_key: :id
  )

  has_many(
    :urls,
    through: :taggings,
    source: :url
  )
end
