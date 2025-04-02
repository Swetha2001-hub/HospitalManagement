class ChangeRoleToIntegerInUsers < ActiveRecord::Migration[6.0]
  def up
    change_column :users, :role, :integer, using: "CASE 
      WHEN role = 'admin' THEN 0 
      WHEN role = 'doctor' THEN 1 
      WHEN role = 'patient' THEN 2 
      ELSE NULL END"
  end

  def down
    change_column :users, :role, :string
  end
end
