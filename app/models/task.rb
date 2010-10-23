class Task < ActiveRecord::Base

  attr_accessor :description, :duration, :owner, :is_finished

end
