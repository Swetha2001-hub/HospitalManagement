class CreateBeds < ActiveRecord::Migration[8.0]
  def change
    create_table :beds do |t|
      t.references :room, null: false, foreign_key: true
      t.string :bed_number
      t.string :status

      t.timestamps
    end
  end
end
