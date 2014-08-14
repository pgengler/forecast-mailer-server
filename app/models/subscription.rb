class Subscription < ActiveRecord::Base
	validates :location, presence: true
	validates :email, presence: true
end
