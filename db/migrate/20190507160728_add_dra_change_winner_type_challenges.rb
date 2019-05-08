class AddDraChangeWinnerTypeChallenges < ActiveRecord::Migration[5.2]
  def change
    remove_column :challenges, :winner
    add_column :challenges, :winner, :integer
    add_column :challenges, :is_draw, :boolean
  end
end
