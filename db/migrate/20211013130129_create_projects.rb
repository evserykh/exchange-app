class CreateProjects < ActiveRecord::Migration[6.1]
  def change
    create_table :projects do |t|
      t.string :api_key

      t.timestamps
    end
    add_index :projects, :api_key, unique: true
  end
end
