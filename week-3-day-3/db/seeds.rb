# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

u1 = User.create!(email: "something@else.gov")
u2 = User.create!(email: "example@else.gov")
u3 = User.create!(email: "a@else.gov")
u4 = User.create!(email: "b@else.gov")
bossUser = User.create!(email: "BOSS@MONEY.GOV", premium: true)

s1 = ShortenedUrl.create_for_user_and_long_url!(User.first, "google.com")
s2 = ShortenedUrl.create_for_user_and_long_url!(User.first, "yahoo.com")
s3 = ShortenedUrl.create_for_user_and_long_url!(User.first, "amazon.com")
s4 = ShortenedUrl.create_for_user_and_long_url!(User.first, "spotify.com")
s5 = ShortenedUrl.create_for_user_and_long_url!(User.first, "cnn.com")

Visit.record_visit!(u1, s2)
Visit.record_visit!(u2, s2)
Visit.record_visit!(u3, s2)
Visit.record_visit!(u4, s2)
Visit.record_visit!(u1, s1)
Visit.record_visit!(u1, s2)
Visit.record_visit!(u1, s3)
Visit.record_visit!(u1, s4)
Visit.record_visit!(u1, s5)

t1 = TagTopic.create!(topic: "Sports")
t2 = TagTopic.create!(topic: "News")
t3 = TagTopic.create!(topic: "Entertainment")
t4 = TagTopic.create!(topic: "Finance")
t5 = TagTopic.create!(topic: "Music")

Tagging.create_new_tag!(s1, t1)
Tagging.create_new_tag!(s1, t3)
Tagging.create_new_tag!(s2, t2)
Tagging.create_new_tag!(s2, t3)
Tagging.create_new_tag!(s2, t3)
Tagging.create_new_tag!(s3, t3)
Tagging.create_new_tag!(s4, t5)
Tagging.create_new_tag!(s5, t4)
