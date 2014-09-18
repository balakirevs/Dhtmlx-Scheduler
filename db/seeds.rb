# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

team1 = Team.create! label: "Team A", open: true
user = team1.users.create! label: "John Smith", email: 'admin@example.com', password: 'admin123', role: 'administrator'
#user.events.create! text: "O"
#user.events.create! text: "K"

#team2 = Team.create! label: "Team B", open: true
#user1 = team2.users.create! label: "David Korn"
#user1.events.create! text: "B"
#user1.events.create! text: "C"