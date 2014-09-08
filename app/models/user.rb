class User < ActiveRecord::Base
	belongs_to :team
	has_many :events
	accepts_nested_attributes_for :events, allow_destroy: true

	def to_params
		"#{id} #{self.label}".parameterize
	end
end
