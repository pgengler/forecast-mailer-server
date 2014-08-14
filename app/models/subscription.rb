class Subscription < ActiveRecord::Base
	validates :location, presence: true
end
