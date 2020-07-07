class Assertion < ApplicationRecord
  belongs_to :request, optional: true
end
