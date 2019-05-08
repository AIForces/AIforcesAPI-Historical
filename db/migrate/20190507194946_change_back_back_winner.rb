class ChangeBackBackWinner < ActiveRecord::Migration[5.2]
  def change
    remove_column :challenges, :winner
    add_column :challenges, :winner, :integer
  end
end
