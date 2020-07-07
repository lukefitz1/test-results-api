class RequestSerializer < ActiveModel::Serializer
  attributes :request_name, :request_id, :timestamp, :assertions

  def assertions
    object.assertions.map do |assertion|
      {
        assertion_name: assertion.assertion_name,
        assertion_result: assertion.assertion_result
      }
    end
  end
end