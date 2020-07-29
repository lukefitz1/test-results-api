class CreateCollections < ActiveRecord::Migration[5.2]
  def change
    create_table :collections, id: :uuid do |t|
      t.string :description
      t.string :date

      t.timestamps
    end
  end
end
