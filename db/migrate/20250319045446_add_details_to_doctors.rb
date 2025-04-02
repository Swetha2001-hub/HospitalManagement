class AddDetailsToDoctors < ActiveRecord::Migration[8.0]
  def change
    add_column :doctors, :first_name, :string
    add_column :doctors, :middle_name, :string
    add_column :doctors, :last_name, :string
    add_column :doctors, :photo, :string
    add_column :doctors, :dob, :date
    add_column :doctors, :contact_number, :string
    add_column :doctors, :email, :string
    add_column :doctors, :nationality, :string
    add_column :doctors, :gender, :string
    #add_column :doctors, :qualifications, :string
    #add_column :doctors, :experience, :string
  end
end
