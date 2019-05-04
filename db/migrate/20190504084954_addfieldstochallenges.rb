class Addfieldstochallenges < ActiveRecord::Migration[5.2]
  def change
    add_column :challenges, :player_1_verdict, :string
    add_column :challenges, :player_2_verdict, :string
    add_column :challenges, :winner, :string
  end
end
