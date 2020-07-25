class ScenarioSerializer < ActiveModel::Serializer
  attributes :id, :scenario_name, :steps

  def steps
    object.steps.map do |step|
      {
        id: step.id,
        step_name: step.step_name,
        result: step.result
      }
    end
  end
end