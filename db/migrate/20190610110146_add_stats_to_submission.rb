class AddStatsToSubmission < ActiveRecord::Migration[5.2]
  def change
    add_column :submissions, :won, :integer
    add_column :submissions, :lost, :integer
    add_column :submissions, :drawn, :integer
    add_column :submissions, :opened, :boolean
  end
end
