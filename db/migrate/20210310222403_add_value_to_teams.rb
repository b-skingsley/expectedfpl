class AddValueToTeams < ActiveRecord::Migration[6.0]
  def change
    add_column :teams, :team_value, :integer
  end
end
