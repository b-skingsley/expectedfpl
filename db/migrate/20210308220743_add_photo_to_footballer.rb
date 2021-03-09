class AddPhotoToFootballer < ActiveRecord::Migration[6.0]
  def change
    add_column :footballers, :photo, :string
  end
end
