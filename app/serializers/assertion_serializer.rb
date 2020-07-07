class AssertionSerializer < ActiveModel::Serializer
  attributes :assertion_name, :assertion_result, :request_id
end