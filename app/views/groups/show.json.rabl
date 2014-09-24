object @group

attributes :id, :label, :open

child users: :children do
	extends "users/index"
end