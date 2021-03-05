class AddStarterToPlayers < ActiveRecord::Migration[6.0]
  def change
    add_column :players, :starter, :boolean, default: false
  end
end
