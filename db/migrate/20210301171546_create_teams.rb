class CreateTeams < ActiveRecord::Migration[6.0]
  def change
    create_table :teams do |t|
      t.integer :fpl_team_id
      t.string :name
      t.integer :summary_overall_points
      t.integer :summary_overall_rank
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
