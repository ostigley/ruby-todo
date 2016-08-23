class AddUserIdToToDos < ActiveRecord::Migration[5.0]
  def change
  	add_column :to_dos, :user_id, :integer
  end
end
