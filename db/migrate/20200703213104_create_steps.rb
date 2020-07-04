class CreateSteps < ActiveRecord::Migration[5.2]
  def change
    create_table :steps, id: :uuid do |t|
      t.string :step_name
      t.string :result

      t.timestamps
    end
  end
end
