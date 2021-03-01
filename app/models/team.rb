class Team < ApplicationRecord
  belongs_to :user
  has_many :team_entries
  has_many :players
end
