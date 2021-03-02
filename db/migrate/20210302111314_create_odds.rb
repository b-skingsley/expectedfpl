class CreateOdds < ActiveRecord::Migration[6.0]
  def change
    create_table :odds do |t|
      t.string :event
      t.float :probability
      t.references :footballer, null: false, foreign_key: true
      t.references :fixture, null: false, foreign_key: true

      t.timestamps
    end
  end
end
