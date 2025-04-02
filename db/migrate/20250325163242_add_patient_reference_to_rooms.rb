class AddPatientReferenceToRooms < ActiveRecord::Migration[7.0]
  def change
    add_foreign_key :rooms, :patients, column: :patient_id, on_delete: :nullify # ✅ Ensures deleting a patient doesn't break rooms
    add_index :rooms, :patient_id
  end
end
