class AddFeatureRefToScenario < ActiveRecord::Migration[5.2]
  def change
    add_reference :scenarios, :feature, type: :uuid, foreign_key: true
  end
end
