class Project
  class RemoveRepo
    def self.perform(project_id)
      begin
        Strano::Repo.remove Project.unscoped.find(project_id).url
      rescue ActiveRecord::RecordNotFound
        return
      end
    end

    def self.perform_async project_id
      Job.create! :project_id => project_id, :visible => false,
        :notes => 'RemoveRepo'
    end
  end
end
