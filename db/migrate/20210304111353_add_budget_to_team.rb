class AddBudgetToTeam < ActiveRecord::Migration[6.0]
  def change
    add_column :teams, :budget, :integer
  end
end
