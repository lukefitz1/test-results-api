class FeatureSerializer < ActiveModel::Serializer
  attributes :id, :feature_name, :created_at, :updated_at, :scenarios

  def scenarios
    object.scenarios.map do |scenario|
      # {
      #   id: scenario.id,
      #   scenario_name: scenario.scenario_name,
      #   steps: scenario.steps
      # }
      ScenarioSerializer.new(scenario)
    end
  end
end