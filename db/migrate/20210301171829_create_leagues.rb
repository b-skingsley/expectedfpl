class CreateLeagues < ActiveRecord::Migration[6.0]
  def change
    create_table :leagues do |t|
      t.integer :fpl_league_id
      t.string :name

      t.timestamps
    end
  end
end
