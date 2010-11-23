class AddStoppedAtToTasks < ActiveRecord::Migration
  def self.up
    add_column :tasks, :stopped_at, :time
  end

  def self.down
    remove_column :tasks, :stopped_at
  end
end
