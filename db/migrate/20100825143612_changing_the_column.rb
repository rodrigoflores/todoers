class ChangingTheColumn < ActiveRecord::Migration
  def self.up
    remove_column :watching_list_users, :user_id
    add_column :watching_list_users, :watching_user_id, :integer
  end

  def self.down
    add_column :watching_list_users, :user_id, :integer
    remove_column :watching_list_users, :watching_user_id
  end
end