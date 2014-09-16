class User < ActiveRecord::Base
	belongs_to :team
	has_many :events, through: :works
	has_many :works
	delegate :pms, :ams, to: :works
	accepts_nested_attributes_for :events, allow_destroy: true
	accepts_nested_attributes_for :works, allow_destroy: true

	def to_params
		"#{id} #{self.label}".parameterize
	end
end
