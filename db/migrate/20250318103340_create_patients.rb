class CreatePatients < ActiveRecord::Migration[8.0]
  def change
    create_table :patients do |t|
      t.references :user, null: false, foreign_key: true
      t.date :date_of_birth
      t.string :address
      t.string :contact_number
      t.string :gender
      t.string :blood_group

      t.timestamps
    end
  end
end
