class AssertionSerializer < ActiveModel::Serializer
  attributes :id, :assertion_name, :assertion_result, :request_id
end