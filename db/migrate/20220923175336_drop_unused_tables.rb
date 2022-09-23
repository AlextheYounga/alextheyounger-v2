class DropUnusedTables < ActiveRecord::Migration[6.0]
  def change
    drop_table :countries
    drop_table :posts
    drop_table :favorite_quotes
  end
end
