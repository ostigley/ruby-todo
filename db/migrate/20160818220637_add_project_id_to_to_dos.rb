class AddProjectIdToToDos < ActiveRecord::Migration[5.0]
  def change
    add_column :to_dos, :project_id, :integer
  end
end
