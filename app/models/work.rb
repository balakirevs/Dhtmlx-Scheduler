class Work < ActiveRecord::Base
	belongs_to :user
	has_many :events
	#has_many :holidays, conditions: ["date >= '#{ DateTime.now.beginning_of_year.strftime('%Y-%m-%d')}'::date"], order: "DATE ASC"
	self.inheritance_column = :period

	validates :period, presence: true

	scope :pms, -> { where(period: 'Pm') }
	scope :ams, -> { where(period: 'Am') }
	accepts_nested_attributes_for :events, allow_destroy: true
	#accepts_nested_attributes_for :holidays, allow_destroy: true

	def self.current_id=(id)
		Thread.current[:work_id] = id
	end
    
  def self.current_id
    Thread.current[:work_id]
  end
	
	class << self
		def periods
			%w(Pm Am Work)
		end
	end 
end