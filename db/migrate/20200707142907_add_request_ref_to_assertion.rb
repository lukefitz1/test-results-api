class AddRequestRefToAssertion < ActiveRecord::Migration[5.2]
  def change
    add_reference :assertions, :request, type: :uuid, foreign_key: true
  end
end
