class Team < ActiveRecord::Base
	belongs_to :account
	has_many :users
	accepts_nested_attributes_for :users, allow_destroy: true
end
