class AddMinutesToFootballer < ActiveRecord::Migration[6.0]
  def change
    add_column :footballers, :minutes, :integer
  end
end
