class CreateToDos < ActiveRecord::Migration[5.0]
  def change
    create_table :to_dos do |t|
      t.text :task
      t.boolean :complete, default: false

      t.timestamps
    end
  end
end
