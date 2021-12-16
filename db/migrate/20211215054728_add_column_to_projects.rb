class AddColumnToProjects < ActiveRecord::Migration[6.0]
  def change
    add_column :projects, :image_url, :string, after: :image_address
  end
end
