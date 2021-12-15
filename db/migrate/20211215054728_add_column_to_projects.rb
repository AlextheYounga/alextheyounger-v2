class AddColumnToProjects < ActiveRecord::Migration[6.0]
  def change
    add_column :projects, :use_github, :boolean, default: false
  end
end
