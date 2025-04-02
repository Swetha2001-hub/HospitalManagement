class AddAssignedPatientToRooms < ActiveRecord::Migration[6.0]
  def change
    add_column :rooms, :assigned_patient, :string
  end
end
