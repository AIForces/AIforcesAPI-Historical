class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.string :name
      t.datetime :started_at
      t.datetime :finished_at
      t.string :rules_file

      t.timestamps
    end
  end
end
