class AddAssociatedDateToTasks < ActiveRecord::Migration
  def self.up
    add_column :tasks, :associated_date, :datetime
  end

  def self.down
    remove_column :tasks, :associated_date
  end
end
