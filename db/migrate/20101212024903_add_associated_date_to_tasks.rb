class AddAssociatedDateToTasks < ActiveRecord::Migration
  def self.up
    add_column :tasks, :associated_date, :time
  end

  def self.down
    remove_column :tasks, :associated_date
  end
end
