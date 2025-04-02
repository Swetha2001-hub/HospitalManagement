class AddDefaultStatusToAppointments < ActiveRecord::Migration[8.0]
  def change
    change_column_default :appointments, :status, "pending"
  end
end
