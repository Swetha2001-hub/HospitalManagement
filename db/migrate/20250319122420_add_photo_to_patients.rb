class AddPhotoToPatients < ActiveRecord::Migration[8.0]
  def change
    add_column :patients, :photo, :string
  end
end
