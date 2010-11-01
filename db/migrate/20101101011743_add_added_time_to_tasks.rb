class AddAddedTimeToTasks < ActiveRecord::Migration
  def self.up
    add_column :tasks, :added_time, :int
  end

  def self.down
    remove_column :tasks, :added_time
  end
end
