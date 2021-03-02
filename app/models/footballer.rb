class Footballer < ApplicationRecord
  belongs_to :club
  has_many :players
  has_many :odds
end
