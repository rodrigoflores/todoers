class HabtmListUser < ActiveRecord::Migration
  def self.up
    create_table :watching_list_users, :id => false do |t|
      t.integer :todo_list_id
      t.integer :user_id
    end
  end

  def self.down
    drop_table :watching_list_users
  end
end
