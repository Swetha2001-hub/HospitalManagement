class AddStatusToRooms < ActiveRecord::Migration[8.0]
  def change
    add_column :rooms, :status, :string
  end
end
