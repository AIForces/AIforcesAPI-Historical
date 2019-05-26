class Addstatepartochallenges < ActiveRecord::Migration[5.2]
  def change
    add_column :challenges, :state_par, :string
  end
end
