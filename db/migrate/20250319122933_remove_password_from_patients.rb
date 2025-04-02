class RemovePasswordFromPatients < ActiveRecord::Migration[8.0]
  def change
    remove_column :patients, :password, :string
    remove_column :patients, :password_confirmation, :string
  end
end
