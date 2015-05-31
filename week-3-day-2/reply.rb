
require_relative 'saveable'

class Reply
  include Saveable
  attr_accessor :subject_question_id, :parent_reply_id, :author_id, :body

  def self.all
    replies = QuestionsDatabase.instance.execute('SELECT * FROM replies')
    replies.map { |reply| Reply.new(reply) }
  end

  def self.find_by_id(id)
    reply_info = QuestionsDatabase.instance.get_first_row(<<-SQL, id)
      SELECT
        *
      FROM
        replies
      WHERE
        id = ?
    SQL

    Reply.new(reply_info)
  end

  def self.find_by_user_id(id)
    reply_info = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
        replies
      WHERE
        author_id = ?
    SQL

    reply_info.map { |reply| Reply.new(reply) }
  end

  def self.find_by_question_id(subject_id)
    all_replies = QuestionsDatabase.instance.execute(<<-SQL, subject_id)
      SELECT
        *
      FROM
        replies
      WHERE
        subject_question_id = ?
    SQL

    all_replies.map { |reply| Reply.new(reply) }
  end

  def initialize( attr = {} )
    @id = attr['id']
    @subject_question_id = attr['subject_question_id']
    @parent_reply_id = attr['parent_reply_id']
    @author_id = attr['author_id']
    @body = attr['body']
  end

  def author
    User.find_by_id(@author_id)
  end

  def question
    Question.find_by_id(@subject_question_id)
  end

  def parent_reply
    Reply.find_by_id(@parent_reply_id)
  end

  def child_replies
    children_info = QuestionsDatabase.instance.execute(<<-SQL, @id)
      SELECT
        *
      FROM
        replies
      WHERE
        parent_reply_id = ?
    SQL

    children_info.map { |info| Reply.new(info) }
  end

  def table_name
    "replies"
  end

  def column_names
    "(subject_question_id, parent_reply_id, author_id, body)"
  end

  def save_values
    [@subject_question_id, @parent_reply_id, @author_id, @body]
  end

  def values_splat
    "(?, ?, ?, ?)"
  end
end
