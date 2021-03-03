class Fixture < ApplicationRecord
  belongs_to :home_team, :class_name => "Club", :foreign_key => :home_team_id
  belongs_to :away_team, :class_name => "Club", :foreign_key => :away_team_id
  has_many :odds

  # validates :kickoff, :gameweek, presence: true
  validates :gameweek, numericality: { greater_than: 0, less_than: 39 }
  validates :h_score, :a_score, numericality: { greater_than_or_equal_to: 0 }
end
