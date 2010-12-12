class ChangeDataTypeForTaskAssociatedDate < ActiveRecord::Migration
  def self.up
    change_table :tasks do |t|
      t.change :associated_date, :datetime
    end
  end

  def self.down
    change_table :tasks do |t|
      t.change :associated_date, :time
    end
  end
end
