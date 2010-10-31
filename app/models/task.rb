class Task < ActiveRecord::Base
  validates_presence_of :description
  validates_presence_of :duration
  validates_presence_of :owner
  validates_presence_of :is_finished, :if => "#{:is_finished}"
  validates_length_of :description, :allow_blank => false, :allow_nil => false, :minimum => 5, :too_short => "Task Description must be at least 5 characters long!"
  validate :new_task_cannot_have_no_owner, :duration_cannot_be_less_than_5_minutes, :new_task_cannot_be_already_started, :new_task_cannot_be_already_finished
  belongs_to :user
  before_validation :default_values

  # ensures is_finished is false by default, not nil
  def initialize(params=nil)
    super
  end

  def default_values
    self.owner = 0 unless self.owner # For now.  Later, we keep track of users. PERHAPS we don't need this b/c one can call @task.user_id using Rails Associations - COMMENT THIS LINE OUT FOR A SPEC TEST TO WORK
    self.is_finished = false unless self.is_finished
    self.started_at = nil unless self.started_at
    self.duration = Time.now unless self.duration
  end
  
  # special validations checks

  def new_task_cannot_have_no_owner
    errors.add(:owner, "Task cannot have no owner!") if
      owner == nil
  end

  def duration_cannot_be_less_than_5_minutes
    errors.add(:duration, "Task duration has to last over 5 minutes!") if
      duration == nil or
      (duration.hour == 0 and duration.min == 0)
  end

  def new_task_cannot_be_already_started
    errors.add(:started_at, "New task cannot be already started!") if
      started_at != nil
  end

  def new_task_cannot_be_already_finished
    errors.add(:is_finished, "New task cannot be already finished!") if
      is_finished == true
  end

end
