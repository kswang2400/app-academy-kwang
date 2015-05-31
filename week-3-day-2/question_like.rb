
class QuestionLike

  def self.likers_for_question_id(question_id)
    user_info = QuestionsDatabase.instance.execute(<<-SQL, question_id)
      SELECT
        *
      FROM
        question_likes
      JOIN
        users ON question_likes.user_id = users.id
      WHERE
        question_id = ?
    SQL

    user_info.map { |info| User.new(info) }
  end

  def self.num_likes_for_question_id(question_id)
    num_likes = QuestionsDatabase.instance.get_first_row(<<-SQL, question_id)
      SELECT
        COUNT(*)
      FROM
        question_likes
      WHERE
        question_id = ?
    SQL

    num_likes['COUNT(*)']
  end

  def self.liked_questions_for_user_id(user_id)
    questions_info = QuestionsDatabase.instance.execute(<<-SQL, user_id)
      SELECT
        *
      FROM
        question_likes
      JOIN
        questions ON question_likes.question_id = questions.id
      WHERE
        user_id = ?
    SQL

    questions_info.map { |info| Question.new(info) }
  end

  def self.most_liked_questions(n)
    questions_info = QuestionsDatabase.instance.execute(<<-SQL, n)
      SELECT
        *, COUNT(*)
      FROM
        question_likes
      JOIN
        questions ON question_likes.question_id = questions.id
      GROUP BY
        questions.id
      ORDER BY
        COUNT(*) DESC
      LIMIT
        ?
    SQL

    questions_info.map { |info| [info["title"], info["COUNT(*)"]] }
  end

  def self.all
    like_info = QuestionsDatabase.instance.execute('SELECT * FROM question_likes')
    like_info.map { |info| QuestionLike.new(info) }
  end

  def initialize( attr = {} )
    @user_id = attr['user_id']
    @question_id = attr['question_id']
  end

end
