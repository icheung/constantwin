class DurationTimeToInt < ActiveRecord::Migration
  def self.up
    remove_column :tasks, :duration
    add_column :tasks, :duration, :integer
  end

  def self.down
    add_column :tasks, :duration, :time
  end
end
