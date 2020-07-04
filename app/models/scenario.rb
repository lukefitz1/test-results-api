class Scenario < ApplicationRecord
  has_many :steps

  belongs_to :feature, optional: true
end
