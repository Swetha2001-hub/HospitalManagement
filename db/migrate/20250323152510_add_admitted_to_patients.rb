class AddAdmittedToPatients < ActiveRecord::Migration[6.0]
  def change
    add_column :patients, :admitted, :boolean, default: false
  end
end
