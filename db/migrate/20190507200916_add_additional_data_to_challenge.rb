class AddAdditionalDataToChallenge < ActiveRecord::Migration[5.2]
  def change
    add_column :challenges, :player1_id, :integer
    add_column :challenges, :player2_id, :integer
    add_column :challenges, :winner_id, :integer
  end
end
