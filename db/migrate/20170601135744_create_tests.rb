class CreateTests < ActiveRecord::Migration[5.0]
  def change
    create_table :tests do |t|
      t.integer :user_id
      t.string :name
      t.string :path
      t.string :description
      t.string :report_data

      t.timestamps
    end
    add_index :tests, [:user_id, :created_at]
  end
end
