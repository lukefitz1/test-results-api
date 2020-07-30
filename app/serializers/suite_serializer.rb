class SuiteSerializer < ActiveModel::Serializer
  attributes :id, :description, :date, :created_at, :features

  def features
    object.features.map do |feature|
      FeatureSerializer.new(feature)
    end
  end
end
