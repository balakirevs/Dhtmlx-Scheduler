collection @teams

attributes :id, :label, :open

child users: :children do
	attributes :id => :key
  attributes :label
end