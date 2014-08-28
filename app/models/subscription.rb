class Subscription < ActiveRecord::Base
	validates :location, presence: true
	validates :email, presence: true

	geocoded_by :location
	after_commit :geocode_in_background, on: [ :create, :update ]

	def self.active
		where('("start" IS NULL AND "end" IS NULL) OR ("start" IS NULL AND ? <= "end") OR ("end" IS NULL AND "start" <= ?) OR (? BETWEEN "start" AND "end")', Date.today, Date.today, Date.today)
	end

	private

	def geocode_in_background
		BackgroundGeocoder.perform_async(id)
	end
end
