class Odd < ApplicationRecord
  belongs_to :footballer
  belongs_to :fixture

  validates :probability, presence: true

end
