
class Question < ActiveRecord::Base

  validates :text, presence: true
  validates :poll_id, presence: true

  has_many(
    :answer_choices,
    class_name: "AnswerChoice",
    foreign_key: :question_id,
    primary_key: :id
  )

  belongs_to(
    :poll,
    class_name: "Poll",
    foreign_key: :poll_id,
    primary_key: :id
  )

  has_many(
    :responses,
    through: :answer_choices,
    source: :different_responses
  )

  def results_n_plus_one
    output = {}

    answer_choices.each do |choice|
      count = 0
      count += choice.different_responses.length
      output[choice.text] = count
    end

    output
  end

  def results_with_includes
    output = {}

    choices = self.answer_choices.includes(:different_responses)
    choices.each do |choice|
      count = 0
      count += choice.different_responses.length
      output[choice.text] = count
    end

    output
  end

  def sql_query
    output = {}

    ac = AnswerChoice.find_by_sql([<<-SQL, id])
      SELECT
        answer_choices.text, COUNT(responses.id) AS count
      FROM
        answer_choices
      LEFT OUTER JOIN
        responses ON answer_choices.id = responses.answer_choice_id
      WHERE
        answer_choices.question_id = ?
      GROUP BY
        answer_choices.id
    SQL

    ac.each do |a|
      output[a.text] = a.count
    end

    output
  end
end
