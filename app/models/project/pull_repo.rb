class Project
  class PullRepo
    def self.perform(project_id)
      begin
        project = Project.find(project_id)
      rescue ActiveRecord::RecordNotFound
        return
      end

      project.update_column :pull_in_progress, true

      Strano::Repo.pull project.url

      Project.update_all({:updated_at => Time.now,
                          :pulled_at => Time.now,
                          :pull_in_progress => false},
                          :id => project_id)
    end

    def self.perform_async project_id
      update_column :pull_in_progress, true
      Job.create! :project_id => project_id, :visible => false,
        :notes => 'PullRepo'
    end
  end
end
