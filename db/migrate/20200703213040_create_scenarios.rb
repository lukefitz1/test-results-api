class CreateScenarios < ActiveRecord::Migration[5.2]
  def change
    create_table :scenarios, id: :uuid do |t|
      t.string :scenario_name

      t.timestamps
    end
  end
end
