class SuiteSerializer < ActiveModel::Serializer
  attributes :id, :description, :date, :features

  def features
    object.features.map do |feature|
      FeatureSerializer.new(feature)
    end
  end
end
