class AddDifficultyToFixtures < ActiveRecord::Migration[6.0]
  def change
    add_column :fixtures, :home_team_difficulty, :integer
    add_column :fixtures, :away_team_difficulty, :integer
  end
end
