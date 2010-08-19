class CreateTodoLists < ActiveRecord::Migration
  def self.up
    create_table :todo_lists do |t|
      t.string :name
      t.text :description
      t.datetime :deadline
      t.integer :user_id
      t.boolean :public, :default => false
      t.timestamps
    end
  end

  def self.down
    drop_table :todo_lists
  end
end
