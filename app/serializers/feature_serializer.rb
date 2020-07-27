class FeatureSerializer < ActiveModel::Serializer
  attributes :id, :feature_name, :created_at, :updated_at, :scenarios

  def scenarios
    object.scenarios.map do |scenario|
      ScenarioSerializer.new(scenario)
    end
  end
end