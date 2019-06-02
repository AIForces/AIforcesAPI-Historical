class CreateGames < ActiveRecord::Migration[5.2]
  def change
    create_table :games do |t|
      t.string :name
      t.string :statement_file
      t.string :visualizer_file
      t.string :checker_file
      t.string :solution_file
      t.float :timeout
      t.integer :memory_limit

      t.timestamps
    end
  end
end
