class Subscription < ActiveRecord::Base
	validates :location, presence: true
	validates :email, presence: true

	geocoded_by :location
	after_validation :geocode, if: ->(obj) { obj.location_changed? }
end
