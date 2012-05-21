class AddPullStatusToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :pull_in_progress, :boolean, :default => false
    add_column :projects, :pulled_at, :datetime
  end
end
