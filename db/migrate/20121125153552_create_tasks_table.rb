class CreateTasksTable < ActiveRecord::Migration
  def up
    create_table :tasks do |t|
      t.text :name, :null => false
      t.text :description
      t.integer :author_id, :null => false
      t.integer :project_id, :null => false
    end

    add_column :jobs, :task_id, :integer
    remove_column :jobs, :task
  end

  def down
    drop_table :tasks

    remove_column :jobs, :task_id
    add_column :jobs, :task, :string
  end
end
