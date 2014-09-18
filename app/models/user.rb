class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
	belongs_to :team
	has_many :events, through: :works
	has_many :works
	delegate :pms, :ams, to: :works
	accepts_nested_attributes_for :events, allow_destroy: true
	accepts_nested_attributes_for :works, allow_destroy: true

	def role?(r)
		role.include? r.to_s
	end

	def to_params
		"#{id} #{self.label}".parameterize
	end
end
