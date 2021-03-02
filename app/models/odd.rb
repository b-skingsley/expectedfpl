class Odd < ApplicationRecord
  belongs_to :footballer
  belongs_to :fixture

  validates :event, :probability, presence: true
end
