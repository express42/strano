class Task < ActiveRecord::Base
  has_many :jobs
  belongs_to :author, :class_name => User
  belongs_to :project

  validate :precense => [:project, :author]
end
