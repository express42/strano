class ChangeJobsTable < ActiveRecord::Migration
  def up
    add_column :jobs, :visible, :boolean, :null => false, :default => true
    remove_column :jobs, :stage
    remove_column :jobs, :verbosity
    remove_column :jobs, :branch
  end

  def down
    remove_column :jobs, :visible
    add_column :jobs, :stage
    add_column :jobs, :verbosity
    add_column :jobs, :branch
  end
end
