class AddFplidToClubs < ActiveRecord::Migration[6.0]
  def change
    add_column :clubs, :fplid, :integer
  end
end
