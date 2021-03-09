class Team < ApplicationRecord
  belongs_to :user
  has_many :team_entries
  has_many :players
  has_many :footballers, through: :players
  has_many :leagues, through: :team_entries
  has_many :transfers

  validates :fpl_team_id, :name, :summary_overall_points, :summary_overall_rank, :user_id, presence: true
  validates :fpl_team_id, :summary_overall_points, :summary_overall_rank, numericality: { only_integer: true }

end
