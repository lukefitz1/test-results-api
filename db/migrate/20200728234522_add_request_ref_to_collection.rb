class AddRequestRefToCollection < ActiveRecord::Migration[5.2]
  def change
    add_reference :requests, :collection, type: :uuid, foreign_key: true
  end
end
