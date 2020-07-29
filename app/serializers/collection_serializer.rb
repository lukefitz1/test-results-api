class CollectionSerializer < ActiveModel::Serializer
  attributes :id, :description, :date, :requests

  def requests
    object.requests.map do |request|
      RequestSerializer.new(request)
    end
  end
end
