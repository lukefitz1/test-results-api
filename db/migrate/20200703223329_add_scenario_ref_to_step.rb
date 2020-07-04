class AddScenarioRefToStep < ActiveRecord::Migration[5.2]
  def change
    add_reference :steps, :scenario, type: :uuid, foreign_key: true
  end
end
