class AddPatientToBeds < ActiveRecord::Migration[8.0]
  def change
    add_reference :beds, :patient, foreign_key: true, null: true
  end
end
