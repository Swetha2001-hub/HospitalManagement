class AddNamesToPatients < ActiveRecord::Migration[8.0]
  def change
    add_column :patients, :first_name, :string
    add_column :patients, :middle_name, :string
    add_column :patients, :last_name, :string
  end
end
