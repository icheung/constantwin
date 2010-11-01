class Task < ActiveRecord::Base
  validates_presence_of :description
  validates_presence_of :duration
  validates_presence_of :user_id
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
    self.is_finished = false unless self.is_finished
    self.started_at = nil unless self.started_at
    self.duration = 15 unless self.duration
    self.user_id = 1 unless self.user_id
    self.added_time = 0 unless self.added_time
  end

  def add_time(amount_of_time)
    self.duration += amount_of_time.minute * 3
    self.save!
  end
  
  # special validations checks

  def new_task_cannot_have_no_owner
    errors.add(:task, "cannot have no owner!") if
      user_id == nil
  end

  def duration_cannot_be_less_than_5_minutes
    errors.add(:task, "duration has to last over 5 minutes!") if
      duration == nil or
      (duration.hour == 0 and duration.min < 5)
  end

  def new_task_cannot_be_already_started
    errors.add(:task, "cannot be already started!") if
      started_at != nil
  end

  def new_task_cannot_be_already_finished
    errors.add(:task, "cannot be already finished!") if
      is_finished == true
  end

end
