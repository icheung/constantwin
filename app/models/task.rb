class Task < ActiveRecord::Base
  validates_presence_of :description
  # validates_presence_of :duration   # no need to b/c we set duration when we start the task instead
  validates_presence_of :user_id
  validates_presence_of :is_finished, :if => "#{:is_finished}"
  validates_length_of :description, :allow_blank => false, :allow_nil => false, :minimum => 5, :too_short => "Task Description must be at least 5 characters long!"
  validate :new_task_cannot_have_no_owner, :new_task_cannot_be_already_finished#, new_task_cannot_be_already_started, :duration_cannot_be_less_than_5_minutes
  belongs_to :user
  before_validation :default_values

  def initialize(params=nil)
    super
  end

  def default_values
    self.user_id = 0 unless self.user_id  # needs to belong to users, handle this later
    self.is_finished = false unless self.is_finished
    self.started_at = nil unless self.started_at
    self.duration = 15 unless self.duration
    self.user_id = 1 unless self.user_id
    self.added_time = 0 unless self.added_time
  end

  def add_time(amount_of_time)
    self.duration += amount_of_time # shouldn't be amount_of_time.minutes b/c its an int
    self.save!
  end
  
  # special validations checks

  def new_task_cannot_have_no_owner
    errors.add(:task, "must have an owner!") if
      user_id == nil
  end

  def duration_cannot_be_less_than_5_minutes
    errors.add(:task, "duration has to last over 5 minutes!") if
      duration != nil && (duration.hour == 0 and duration.min < 5)
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
