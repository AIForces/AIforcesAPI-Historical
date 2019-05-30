class AddTestedTimeTocChallenges < ActiveRecord::Migration[5.2]
  def change
    add_column :challenges, :tested_time, :datetime
  end
end
