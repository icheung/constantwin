class TaskObserver < ActiveRecord::Observer
  
  def before_save(task)
    # add_more_time_to_task_duration(task)
  end

  # obsolete method, now that this is taken care of in tasks_controller.rb
  def add_more_time_to_task_duration(task)
    if task.started_at and task.added_time > 0
      task.duration += task.added_time
      task.added_time = 0
    end
  end    

end
