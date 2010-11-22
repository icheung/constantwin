class AddActiveTaskToTask < ActiveRecord::Migration
  def self.up
    add_column :tasks, :active_task, :boolean
  end

  def self.down
    remove_column :tasks, :active_task
  end
end
