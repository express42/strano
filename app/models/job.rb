require 'kernel'
require 'open3'

class Job < ActiveRecord::Base
  include Ansible

  belongs_to :project
  belongs_to :user
  belongs_to :task

  default_scope order('created_at DESC')
  default_scope where(:deleted_at => nil, :visible => true)

  validate :precense => :task, :if => :visible

  def self.deleted
    self.unscoped.where 'deleted_at IS NOT NULL'
  end

  def perform
    Rails.logger.info "Performing Job #{id}"
    if visible?
      Project::PullRepo.perform(project_id) unless project.pull_in_progress?

      success = true

      FileUtils.chdir project.repo.path do
        out, status = Open3.capture2e(task.name)

        puts out

        success = status.success?
      end

    else
      # perform system task
      case notes
      when 'PullRepo'
        Project::PullRepo.perform project_id
      when 'CloneRepo'
        Project::CloneRepo.perform project_id
      when 'RemoveRepo'
        Project::RemoveRepo.perform project_id
      end
    end
    update_attributes :completed_at => Time.now, :success => success
  end

  def complete?
    !completed_at.nil?
  end

  def command
    "#{stage} #{task}"
  end

  def puts(msg)
    update_attribute :results, (results_before_type_cast || '') + msg unless msg.blank?
  end

  def results
    unless (res = read_attribute(:results)).blank?
      escape_to_html res
    end
  end

  private

    def full_command
      %W(-f #{Rails.root.join('Capfile.repos')} -f Capfile -Xx#{verbosity}) + branch_setting + command.split(' ')
    end

    def branch_setting
      %W(-s branch=#{branch}) unless branch.blank?
    end

end
