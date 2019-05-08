class ChangeBackWinner < ActiveRecord::Migration[5.2]
  def change
    remove_column :challenges, :winner
    add_column :challenges, :winner, :string
  end
end
