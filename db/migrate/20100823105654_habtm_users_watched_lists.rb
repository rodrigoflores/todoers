class HabtmUsersWatchedLists < ActiveRecord::Migration
  def self.up
    create_table :users_watched_lists, :id => false do |t|
      t.integer :user_id
      t.integer :list_id
    end
  end

  def self.down
    drop_table :developers_projects
  end
end
