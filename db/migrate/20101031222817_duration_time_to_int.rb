class DurationTimeToInt < ActiveRecord::Migration
  def self.up
    change_column :tasks, :duration, :integer
  end

  def self.down
    change_column :tasks, :duration, :time
  end
end
