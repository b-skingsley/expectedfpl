class CreateFootballers < ActiveRecord::Migration[6.0]
  def change
    create_table :footballers do |t|
      t.string :first_name
      t.string :last_name
      t.string :web_name
      t.integer :price
      t.string :position
      t.integer :expected_points
      t.integer :total_points
      t.integer :goals
      t.integer :assists
      t.integer :clean_sheets
      t.integer :yellow_cards
      t.integer :red_cards
      t.integer :saves
      t.integer :goals_conceded
      t.integer :own_goals
      t.integer :penalties_saved
      t.integer :penalties_missed
      t.integer :bonus
      t.integer :bps
      t.references :club, null: false, foreign_key: true

      t.timestamps
    end
  end
end
