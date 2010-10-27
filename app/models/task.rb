class Task < ActiveRecord::Base
  validates_presence_of :description
  validates_presence_of :duration
  validates_presence_of :owner
  validates_presence_of :is_finished, :if => "is_finished.false?"
  validates_length_of :description, :allow_blank => false, :allow_nil => false, :minimum => 5, :too_short => "Task Description must be at least 5 characters long!"

  belongs_to :user

  # ensures is_finished is false by default, not nil
  def initialize(params=nil)
    super
    self.is_finished = false
    self.started_at = nil
  end
end
