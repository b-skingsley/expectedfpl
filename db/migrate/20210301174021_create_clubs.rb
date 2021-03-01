class CreateClubs < ActiveRecord::Migration[6.0]
  def change
    create_table :clubs do |t|
      t.string :name
      t.string :short_name
      t.string :form

      t.timestamps
    end
  end
end
