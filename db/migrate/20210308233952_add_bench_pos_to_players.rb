class AddBenchPosToPlayers < ActiveRecord::Migration[6.0]
  def change
    add_column :players, :bench_pos, :integer, default: nil
  end
end
