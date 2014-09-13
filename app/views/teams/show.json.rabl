collection @teams

attributes :id, :label, :open

child users: :children do
	extends "users/index"

	child works: :children do
	  extends "works/index"
  end
end