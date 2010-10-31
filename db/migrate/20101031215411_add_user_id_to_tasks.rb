class AddUserIdToTasks < ActiveRecord::Migration
  def self.up
    remove_column :tasks, :owner
    add_column :tasks, :user_id, :int
  end

  def self.down
    add_column :tasks, :owner, :int
    remove_column :tasks, :user_id
  end
end
