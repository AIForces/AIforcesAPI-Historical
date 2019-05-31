class AddStartedTestingTime < ActiveRecord::Migration[5.2]
  def change
    add_column :challenges, :started_testing_at, :datetime
  end
end
