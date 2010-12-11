class AddPausedAtToTasks < ActiveRecord::Migration
  def self.up
    add_column :tasks, :paused_at, :time
  end

  def self.down
    remove_column :tasks, :paused_at
  end
end

