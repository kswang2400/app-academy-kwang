
require_relative 'saveable'

class User
  include Saveable
  attr_accessor :fname, :lname, :id

  def self.all
    users = QuestionsDatabase.instance.execute('SELECT * FROM users')
    users.map { |user| User.new(user) }
  end

  def self.find_by_id(id)
    user_info = QuestionsDatabase.instance.get_first_row(<<-SQL, id)
      SELECT
        *
      FROM
        users
      WHERE
        id = ?
    SQL

    User.new(user_info)
  end

  def self.find_by_name(fname, lname)
    user_info = QuestionsDatabase.instance.get_first_row(<<-SQL, fname, lname)
      SELECT
        *
      FROM
        users
      WHERE
        fname = ? AND lname = ?
    SQL

    User.new(user_info)
  end

  def initialize(attr = {})
    @fname = attr["fname"]
    @lname = attr["lname"]
    @id = attr["id"]
  end

  def authored_replies
    Reply.find_by_user_id(@id)
  end

  def authored_questions
    Question.find_by_author_id(@id)
  end

  def followed_questions
    QuestionFollow.followed_questions_for_user_id(@id)
  end

  def liked_questions
    QuestionLike.liked_questions_for_user_id(@id)
  end

  def average_karma
    average_karma = QuestionsDatabase.instance.get_first_value(<<-SQL, @id)
      SELECT
        CAST(COUNT(question_likes.id) AS FLOAT) /
        COUNT(DISTINCT(question_id))
        AS average_karma
      FROM
        questions
      LEFT OUTER JOIN
        question_likes ON questions.id = question_likes.question_id
      WHERE
        author_id = ?
    SQL

    average_karma
  end

  def table_name
    "users"
  end

  def column_names
    "(fname, lname)"
  end

  def save_values
    [@fname, @lname]
  end

  def values_splat
    "(?, ?)"
  end
end
