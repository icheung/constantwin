class Task < ActiveRecord::Base
  validates_presence_of :description
  validates_presence_of :duration
  validates_presence_of :owner

  belongs_to :user
end
