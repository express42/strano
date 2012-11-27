namespace :bg do
  desc "Run jobs in background"
  task :worker => [:environment] do
    ActiveRecord::Base.logger = Logger.new(File.join(Rails.root, 'log/worker.log'))
    while true
      while job = Job.where(:visible => false, :completed_at => nil).reorder(:created_at).first do
        job.perform
      end

      while job = Job.where(:visible => true, :completed_at => nil).reorder(:created_at).first do
        job.perform
      end

      sleep 0.5
    end
  end
end
