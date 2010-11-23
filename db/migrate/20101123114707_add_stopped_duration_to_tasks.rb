class AddStoppedDurationToTasks < ActiveRecord::Migration
  def self.up
    add_column :tasks, :stopped_duration, :time
  end

  def self.down
    remove_column :tasks, :stopped_duration
  end
end
