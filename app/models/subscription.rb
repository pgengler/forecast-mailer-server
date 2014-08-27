class Subscription < ActiveRecord::Base
	validates :location, presence: true
	validates :email, presence: true

	geocoded_by :location
	after_validation ->(obj) { BackgroundGeocoder.perform_async(obj.id) }, if: ->(obj) { obj.location_changed? }

	def self.active
		where('(start IS NULL AND end IS NULL) OR (start IS NULL AND ? <= end) OR (end IS NULL AND start <= ?) OR (? BETWEEN start AND end)', Date.today, Date.today, Date.today)
	end
end
