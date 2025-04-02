class AddAdmittedToMedicalRecords < ActiveRecord::Migration[6.0]
  def change
    add_column :medical_records, :admitted, :boolean, default: false, null: false
  end
end
