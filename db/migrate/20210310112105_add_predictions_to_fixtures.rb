class AddPredictionsToFixtures < ActiveRecord::Migration[6.0]
  def change
    add_column :fixtures, :ht_possible_goals, :float
    add_column :fixtures, :at_possible_goals, :float
    add_column :fixtures, :ht_clean_sheet_probability, :float
    add_column :fixtures, :at_clean_sheet_probability, :float
  end
end
