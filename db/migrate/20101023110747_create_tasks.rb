class CreateTasks < ActiveRecord::Migration
  def self.up
    create_table :tasks do |t|
      t.string :description
      t.time :duration
      t.integer :owner
      t.boolean :is_finished

      t.timestamps
    end
  end

  def self.down
    drop_table :tasks
  end
end
