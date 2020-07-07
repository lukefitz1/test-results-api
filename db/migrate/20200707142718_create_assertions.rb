class CreateAssertions < ActiveRecord::Migration[5.2]
  def change
    create_table :assertions, id: :uuid do |t|
      t.string :assertion_name
      t.string :assertion_result

      t.timestamps
    end
  end
end
