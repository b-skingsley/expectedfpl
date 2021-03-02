class League < ApplicationRecord
  has_many :team_entries

  validates :name, :fpl_league_id, presence: true
  validates :fpl_league_id, numericality: { only_integer: true }
end
