class CreateRequests < ActiveRecord::Migration[5.2]
  def change
    create_table :requests, id: :uuid do |t|
      t.string :request_id
      t.string :request_name

      t.timestamps
    end
  end
end
