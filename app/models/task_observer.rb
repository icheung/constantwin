class TaskObserver < ActiveRecord::Observer
  
  def before_save(task)
    #validate_stuff(task)
  end

  # obsolete method, now that this is taken care of in tasks_controller.rb
  def validate_stuff(task)
  end    

end
