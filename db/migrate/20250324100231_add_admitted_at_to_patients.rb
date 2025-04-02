class AddAdmittedAtToPatients < ActiveRecord::Migration[8.0]
  def change
    add_column :patients, :admitted_at, :datetime
  end
end
