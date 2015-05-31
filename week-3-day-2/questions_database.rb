
require 'singleton'
require 'sqlite3'

require_relative 'user'
require_relative 'question'
require_relative 'reply'
require_relative 'question_follow'
require_relative 'question_like'
require_relative 'saveable'

class QuestionsDatabase < SQLite3::Database
  include Singleton

  def initialize
    super('questions.db')
    self.results_as_hash = true
    self.type_translation = true
  end
end

if __FILE__ == $PROGRAM_NAME
  users = User.all
  questions = Question.all
  replies = Reply.all
  question_follows = QuestionFollow.all
  question_likes = QuestionLike.all

  cj = users[0]
  david = users[1]
  andrew = users[2]

  example_question = questions[0]

  example_reply = replies[2]

  p david.average_karma

  new_user = User.new({"fname" => "Velina", "lname" => "VVVVVVVV"})
  p new_user
  new_user.save
  users = User.all
  p users

  new_reply = Reply.new({ "subject_question_id" => 2,
                          "parent_reply_id"     => 5,
                          "author_id"           => 6,
                          "body"                => "Order it from Amazon"}
                          )
  p new_reply
  new_reply.save
  p replies

  new_question = Question.new({ "title"     => "Does the BART run all night?",
                                "body"      => "Can I take the BART home after midnight?",
                                "author_id" => 4}
                                )
  p new_question
  new_question.save
  p Question.all
  new_question.body = "CHANGECHANGECHANGECHANGE"
  p new_question
  new_question.save
  p Question.all
  p questions
end
