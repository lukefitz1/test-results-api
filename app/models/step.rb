class Step < ApplicationRecord
  belongs_to :scenario, optional: true
end
