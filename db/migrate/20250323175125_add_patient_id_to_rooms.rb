class AddPatientIdToRooms < ActiveRecord::Migration[8.0]
  def change
    add_column :rooms, :patient_id, :integer
  end
end
