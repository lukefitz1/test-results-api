class AddTimestampToRequests < ActiveRecord::Migration[5.2]
  def change
    add_column :requests, :timestamp, :string
  end
end
