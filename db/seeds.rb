team = Team.create! label: "Team A", open: true
user = team.users.create! label: "John Smith", email: 'admin@example.com', password: 'admin123', role: 'administrator'
user2 = team.users.create! label: "James Brown", email: 'editor@example.com', password: 'editor123', role: 'editor'
user3 = team.users.create! label: "Linda Bale", email: 'manager@example.com', password: 'manager123', role: 'manager'
#user.events.create! text: "O"
#user.events.create! text: "K"