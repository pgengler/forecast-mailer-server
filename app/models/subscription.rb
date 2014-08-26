class Subscription < ActiveRecord::Base
	validates :location, presence: true
	validates :email, presence: true

	geocoded_by :location
	after_validation ->(obj) { BackgroundGeocoder.perform_async(obj.id) }, if: ->(obj) { obj.location_changed? }
end
