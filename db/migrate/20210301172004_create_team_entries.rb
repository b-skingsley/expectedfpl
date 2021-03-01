class CreateTeamEntries < ActiveRecord::Migration[6.0]
  def change
    create_table :team_entries do |t|
      t.references :team, null: false, foreign_key: true
      t.references :league, null: false, foreign_key: true

      t.timestamps
    end
  end
end
