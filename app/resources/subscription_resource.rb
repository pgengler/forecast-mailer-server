class SubscriptionResource < JSONAPI::Resource
  attributes :email, :end, :location, :start, :units, :created_at, :updated_at, :geocoded

  def end
    @model.end&.strftime('%Y-%m-%d')
  end

  def start
    @model.start&.strftime('%Y-%m-%d')
  end

  def geocoded
    @model.geocoded?
  end

  def self.updatable_fields(context)
    super - [:created_at, :updated_at, :geocoded]
  end

  def self.creatable_fields(context)
    self.updatable_fields context
  end
end
