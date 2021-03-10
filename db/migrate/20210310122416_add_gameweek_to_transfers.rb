class AddGameweekToTransfers < ActiveRecord::Migration[6.0]
  def change
    add_column :transfers, :gw, :integer
  end
end
