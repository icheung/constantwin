class Task < ActiveRecord::Base

  belongs_to :user
  before_validation :default_values

  validates_presence_of :description
  validates_presence_of :user_id
  validates_numericality_of :duration, :only_integer => true, :in => 15..60, :message => "Minutes can only be whole number!"
  validates_numericality_of :added_time, :only_integer => true, :in => 15..60, :message => "Minutes can only be whole number!"
  validates_presence_of :is_finished, :if => "#{:is_finished}"
  validates_length_of :description, :allow_blank => false, :allow_nil => false, :minimum => 5, :too_short => "Task Description must be at least 5 characters long!"
  validate :new_task_cannot_be_already_finished, :new_task_cannot_be_already_started
  #:duration_cannot_be_less_than_5_minutes # commented this validation out b/c it makes clearing the duration hard


  def initialize(params=nil)
    super
  end

  def default_values
    self.user_id = 1 unless self.user_id  # needs to belong to users, handle this later, maybe use self.user.id instead?
    self.is_finished = false unless self.is_finished
    self.duration = 15 unless self.duration
    self.added_time = 0 unless self.added_time
    self.started_at = nil unless self.started_at
    self.paused_at = nil unless self.paused_at
  end
  
  def resume_time(resumed_time)
    total_paused_time = Time.at(resumed_time.to_time - self.paused_at.to_time)
    #total_paused_time_mins = total_paused_time.min
    self.started_at += (total_paused_time.min * 60 + total_paused_time.sec)
    self.save
    
    logger.debug "***** IN THE TASK MODEL ***** total_paused_time: #{total_paused_time}"
    
  end
  
  def update_paused_time(paused_time)
    self.paused_at = paused_time
    self.save
    
    logger.debug "***** IN THE TASK MODEL ***** paused_time: #{paused_time}"
    
  end

  #def update_added_time(paused_duration)
  #  self.added_time += paused_duration
  #  self.save
  #end

  def update_duration()
    #self.started_at = Time.now
    self.duration += self.added_time.abs
    self.added_time = 0
    self.save
  end
  
  def clear_duration()
    self.started_at = Time.now
    self.duration = 0
    self.save
  end


  # special validations checks

  def new_task_cannot_have_no_owner
    errors.add(:task, "must have an owner!") if
    user_id == nil
  end

  # commented this validation out b/c it makes clearing the duration hard
  #def duration_cannot_be_less_than_5_minutes
  #  errors.add(:task, "duration has to last over 5 minutes!") if
  #  duration != nil && (duration.hour == 0 and duration.min < 5)
  #end

  # may be useful later
  def added_time_cannot_be_of_invalid_format
    errors.add(:task, "added time has to be an integer!") unless
    added_time.instance_of?(Fixnum)
  end


  def new_task_cannot_be_already_started
    errors.add(:task, "cannot be already started!") if
    started_at != nil and created_at.nil?
  end

  def new_task_cannot_be_already_finished
    errors.add(:task, "cannot be already finished!") if
    is_finished == true
  end

  def validate_added_duration
    self.added_time.kind_of?(Integer) and (5..60) === self.added_time
  end

end
