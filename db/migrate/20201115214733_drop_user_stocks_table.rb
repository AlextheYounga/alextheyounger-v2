class DropUserStocksTable < ActiveRecord::Migration[5.2]
  def change
    drop_table :user_stocks
  end
end
