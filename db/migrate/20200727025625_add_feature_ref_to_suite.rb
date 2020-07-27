class AddFeatureRefToSuite < ActiveRecord::Migration[5.2]
  def change
    add_reference :features, :suite, type: :uuid, foreign_key: true
  end
end
