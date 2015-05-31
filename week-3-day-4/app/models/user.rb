class User < ActiveRecord::Base

  validates :user_name, presence: true, uniqueness: true

  has_many(
    :authored_polls,
    class_name: "Poll",
    foreign_key: :author_id,
    primary_key: :id
  )

  has_many(
    :responses,
    class_name: "Response",
    foreign_key: :user_id,
    primary_key: :id
  )

  def completed_polls
    query = Poll.find_by_sql([<<-SQL, id])
    SELECT
      polls.*, COUNT(questions.id) AS countq, COUNT(responses.id) AS countr
    FROM
      polls
    JOIN
      questions on polls.id = questions.poll_id
    JOIN
      answer_choices on questions.id = answer_choices.question_id
    JOIN
      responses ON answer_choices.id = responses.answer_choice_id
    WHERE
      responses.user_id = ?
    GROUP BY
      polls.id
    HAVING
      COUNT(questions.id) == COUNT(responses.id)
    SQL
    
    query
  end




end
