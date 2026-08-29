class Subscription < ActiveRecord::Base
	validates :location, presence: true
	validates :email, presence: true

	geocoded_by :location
	after_create_commit :geocode_in_background
	after_update_commit :geocode_in_background_if_location_changed

	def self.active
		where('("start" IS NULL AND "end" IS NULL) OR ("start" IS NULL AND ? <= "end") OR ("end" IS NULL AND "start" <= ?) OR (? BETWEEN "start" AND "end")', Date.today, Date.today, Date.today)
	end

	private

	def geocode_in_background
		BackgroundGeocoder.perform_later(id)
	end

	def geocode_in_background_if_location_changed
		geocode_in_background if saved_change_to_location?
	end
end
