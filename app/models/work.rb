class Work < ActiveRecord::Base
	belongs_to :user
	has_many :events
	self.inheritance_column = :period

	validates :period, presence: true

	scope :pms, -> { where(period: 'Pm') }
	scope :ams, -> { where(period: 'Am') }
	accepts_nested_attributes_for :events, allow_destroy: true
	
	class << self
		def periods
			%w(Pm Am Work)
		end
	end 
end