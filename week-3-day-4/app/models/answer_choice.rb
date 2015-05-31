class AnswerChoice < ActiveRecord::Base
  validates :text, presence: true
  validates :question_id, presence: true

  belongs_to(
    :question,
    class_name: "Question",
    foreign_key: :question_id,
    primary_key: :id
  )

  has_many(
    :different_responses,
    class_name: "Response",
    foreign_key: :answer_choice_id,
    primary_key: :id
  )
end
