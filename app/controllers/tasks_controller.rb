class TasksController < InheritedResources::Base

  belongs_to :project
  before_filter :authenticate_user!
  before_filter :ensure_accessibility_by_current_user, :except => [:new, :create]

  actions :new, :create

  def new
    @task = parent.tasks.build params[:task]
    new!
  end

  def create
    @task = parent.tasks.build params[:task]
    @task.author = current_user
    create!
  end

  private

    def ensure_accessibility_by_current_user
      unless resource.accessible_by? current_user
        redirect_to collection_path, :alert => "You do not have access to this project '#{resource}'."
      end
    end
end

