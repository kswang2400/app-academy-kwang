
require_relative 'saveable'

class Question
  include Saveable
  attr_accessor :title, :body, :author_id, :id

  def self.all
    questions = QuestionsDatabase.instance.execute('SELECT * FROM questions')
    questions.map { |question| Question.new(question)}
  end

  def self.find_by_id(id)
    question_info = QuestionsDatabase.instance.get_first_row(<<-SQL, id)
      SELECT
        *
      FROM
        questions
      WHERE
        id = ?
    SQL

    Question.new(question_info)
  end

  def self.find_by_author_id(author_id)
    authors_questions = QuestionsDatabase.instance.execute(<<-SQL, author_id)
    SELECT
      *
    FROM
      questions
    WHERE
      author_id = ?
    SQL

    authors_questions.map { |question| Question.new(question) }
  end

  def self.most_liked(n)
    QuestionLike.most_liked_questions(n)
  end

  def initialize(attr = {})
    @id = attr["id"]
    @title = attr["title"]
    @body = attr["body"]
    @author_id = attr['author_id']
  end

  def author
    User.find_by_id(@author_id)
  end

  def replies
    Reply.find_by_question_id(@id)
  end

  def followers
    QuestionFollow.followers_for_question_id(@id)
  end

  def likers
    QuestionLike.likers_for_question_id(@id)
  end

  def num_likes
    QuestionLike.num_likes_for_question_id(@id)
  end

  def table_name
    "questions"
  end

  def column_names
    "(title, body, author_id)"
  end

  def save_values
    [@title, @body, @author_id]
  end

  def values_splat
    "(?, ?, ?)"
  end

  def update_values
    "title='#{@title}', body='#{@body}', author_id='#{@author_id}'"
  end
end
