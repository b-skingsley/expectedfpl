class CreateFixtures < ActiveRecord::Migration[6.0]
  def change
    create_table :fixtures do |t|
      t.datetime :kickoff
      t.integer :gameweek
      t.integer :h_score
      t.integer :a_score
      t.references :home_team, null: false, foreign_key: { to_table: :clubs }
      t.references :away_team, null: false, foreign_key: { to_table: :clubs }

      t.timestamps
    end
  end
end
