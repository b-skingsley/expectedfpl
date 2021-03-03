class AddFplidToFootballers < ActiveRecord::Migration[6.0]
  def change
    add_column :footballers, :fplid, :integer, null: false
  end
end
