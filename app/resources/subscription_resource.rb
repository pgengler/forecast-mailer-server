class SubscriptionResource < JSONAPI::Resource
  attributes :email, :end, :location, :start, :units

  def end
    @model.end&.strftime('%Y-%m-%d')
  end

  def start
    @model.start&.strftime('%Y-%m-%d')
  end
end
