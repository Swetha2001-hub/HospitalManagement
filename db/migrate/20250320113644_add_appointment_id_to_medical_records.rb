class AddAppointmentIdToMedicalRecords < ActiveRecord::Migration[8.0]
  def change
    add_column :medical_records, :appointment_id, :integer
  end
end
