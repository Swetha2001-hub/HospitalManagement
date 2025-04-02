class AddEmailToPatients < ActiveRecord::Migration[8.0]
  def change
    add_column :patients, :email, :string
  end
end
