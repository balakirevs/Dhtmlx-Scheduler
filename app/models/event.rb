class Event < ActiveRecord::Base
	#has_many :users, through: :works
	belongs_to :user
	belongs_to :work
	#accepts_nested_attributes_for :users, allow_destroy: true
end
