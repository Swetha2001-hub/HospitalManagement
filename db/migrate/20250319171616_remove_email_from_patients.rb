class RemoveEmailFromPatients < ActiveRecord::Migration[8.0]
  def change
    remove_column :patients, :email, :string
  end
end
