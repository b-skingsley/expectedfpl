class CreateTransfers < ActiveRecord::Migration[6.0]
  def change
    create_table :transfers do |t|
      t.references :team, null: false, foreign_key: true
      t.references :player_in, null: false, foreign_key: { to_table: :footballers }
      t.references :player_out, null: false, foreign_key: { to_table: :footballers }

      t.timestamps
    end
  end
end
