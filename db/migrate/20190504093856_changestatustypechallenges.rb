class Changestatustypechallenges < ActiveRecord::Migration[5.2]
  def change
    remove_column :challenges, :status
    add_column :challenges, :status, :string
  end
end
