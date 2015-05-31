class Response < ActiveRecord::Base

  validates :user_id, presence: true
  validates :answer_choice_id, presence: true
  validate :respondent_has_not_already_answered_question
  validate :respondent_cannot_be_author

  belongs_to(
    :respondent,
    class_name: "User",
    foreign_key: :user_id,
    primary_key: :id
  )

  belongs_to(
    :answer_choice,
    class_name: "AnswerChoice",
    foreign_key: :answer_choice_id,
    primary_key: :id
  )

  has_one(
    :question,
    through: :answer_choice,
    source: :question
  )

  def sibling_responses
    question.responses.where( "answer_choices.question_id = ?", question.id )
  end

  def respondent_has_not_already_answered_question
    if sibling_responses.where( "user_id = ?", respondent.id ).count > 0
      errors.add(:already_answered, "User has already answered question")
    end
  end

  def respondent_cannot_be_author
    if answer_choice.question.poll.author_id == user_id
      errors.add(:dont_rig, "You can't answer your own question")
    end
  end

end
