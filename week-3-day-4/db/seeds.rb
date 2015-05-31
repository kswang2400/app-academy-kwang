# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

u1 = User.create!(user_name: "User1")
u2 = User.create!(user_name: "User2")
u3 = User.create!(user_name: "User3")
u4 = User.create!(user_name: "User4")

Poll.create!(title: "San Francisco Restaurants", author_id: 1)      # P1

Question.create!( text: "What is your favorite San Francisco pizza restaurant?",
                  poll_id: 1)                                       # Q1
Question.create!( text: "What is your least favorite San Francisco pizza restaurant?",
                  poll_id: 1)                                       # Q2

Poll.create!(title: "San Francisco Attractions", author_id: 2)      # P2

Question.create!(text: "Golden Gate Bridge or AT&T Park?", poll_id: 2)
                                                                    # Q3

AnswerChoice.create!(text: "Tony's", question_id: 1)                # A1
AnswerChoice.create!(text: "Golden Boy Pizza", question_id: 1)      # A2
AnswerChoice.create!(text: "Pizza Inferno", question_id: 1)         # A3

AnswerChoice.create!(text: "Tony's", question_id: 2)                # A4
AnswerChoice.create!(text: "Golden Boy Pizza", question_id: 2)      # A5
AnswerChoice.create!(text: "Pizza Inferno", question_id: 2)         # A6

AnswerChoice.create!(text: "Golden Gate Bridge", question_id: 3)    # A7
AnswerChoice.create!(text: "AT&T Park", question_id: 3)             # A8

Response.create!(user_id: 2, answer_choice_id: 1)
Response.create!(user_id: 2, answer_choice_id: 6)
Response.create!(user_id: 3, answer_choice_id: 2)
Response.create!(user_id: 3, answer_choice_id: 6)
Response.create!(user_id: 4, answer_choice_id: 1)
Response.create!(user_id: 4, answer_choice_id: 6)
