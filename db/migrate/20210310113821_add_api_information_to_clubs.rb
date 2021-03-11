class AddApiInformationToClubs < ActiveRecord::Migration[6.0]
  def change
    add_column :clubs, :number_of_games_at_home, :integer
    add_column :clubs, :season_total_goals_scored_at_home, :integer
    add_column :clubs, :season_total_goals_conceded_at_home, :integer
    add_column :clubs, :number_of_games_away, :integer
    add_column :clubs, :season_total_goals_scored_away, :integer
    add_column :clubs, :season_total_goals_conceded_away, :integer
  end
end
