class Fixture < ApplicationRecord
  belongs_to :home_team, :class_name => "Club", :foreign_key => ':home_team_id'
  belongs_to :away_team, :class_name => "Club", :foreign_key => ':away_team_id'
  has_many :odds
end
