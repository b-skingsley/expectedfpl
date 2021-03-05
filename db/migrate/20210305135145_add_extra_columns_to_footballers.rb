class AddExtraColumnsToFootballers < ActiveRecord::Migration[6.0]
  def change
    add_column :footballers, :chance_of_playing_next_round, :integer
    add_column :footballers, :chance_of_playing_this_round, :integer
    add_column :footballers, :news, :text
    add_column :footballers, :form, :string
  end
end
