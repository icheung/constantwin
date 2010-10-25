class Task < ActiveRecord::Base
  validates_presence_of :description
  validates_presence_of :duration
  validates_presence_of :owner

  # assoc, can uncomment later
  # belongs_to :user
end
