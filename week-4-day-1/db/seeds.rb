# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create!(username: "zach.reisman@gmail.com")
User.create!(username: "kevin@gmail.com")
User.create!(username: "Ned@appacademy.com")

Contact.create!(name: "CJ", email: "CJ@appacademy.com", user_id: 3)
Contact.create!(name: "Judy", email: "Judy@appacademy.com", user_id: 2)
Contact.create!(name: "Eric", email: "Eric@appacademy", user_id: 1)

ContactShare.create!(contact_id: 1, user_id: 2)
ContactShare.create!(contact_id: 1, user_id: 1)
ContactShare.create!(contact_id: 2, user_id: 1)
