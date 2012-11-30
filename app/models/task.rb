class Task < ActiveRecord::Base

  ARG_PLACEHOLDER = /##/

  has_many :jobs
  belongs_to :author, :class_name => User
  belongs_to :project

  validate :precense => [:project, :author]

  def with_argument?
    name.match(ARG_PLACEHOLDER)
  end

end
