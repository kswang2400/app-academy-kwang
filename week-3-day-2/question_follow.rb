
class QuestionFollow
  
    def self.all
      follow_info = QuestionsDatabase.instance.execute('SELECT * FROM question_follows')
      follow_info.map { |info| QuestionFollow.new(info)}
    end

    def self.followers_for_question_id(question_id)
      user_info = QuestionsDatabase.instance.execute(<<-SQL, question_id)
        SELECT
          *
        FROM
          question_follows
        JOIN
          users ON question_follows.user_id = users.id
        WHERE
          question_id = ?
      SQL

      user_info.map { |info| User.new(info) }
    end

    def self.followed_questions_for_user_id(user_id)
      questions_info = QuestionsDatabase.instance.execute(<<-SQL, user_id)
        SELECT
          *
        FROM
          question_follows
        JOIN
          questions ON question_follows.question_id = questions.id
        WHERE
          user_id = ?
      SQL

      questions_info.map { |info| Question.new(info) }
    end

    def self.most_followed_questions(n)
      most_followed = QuestionsDatabase.instance.execute(<<-SQL, n)
        SELECT
          *, COUNT(*)
        FROM
          question_follows
        JOIN
          questions ON question_follows.question_id = questions.id
        GROUP BY
          question_id
        ORDER BY
          COUNT(*) DESC
        LIMIT
          ?
      SQL

      # most_followed.map { |info| Question.new(info) }
      most_followed.map { |info| [info["title"], info["COUNT(*)"]] }
    end

    def initialize(attr = {})
      @user_id = attr['user_id']
      @question_id = attr['question_id']
    end
end
