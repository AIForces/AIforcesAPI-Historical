class CreateChallenges < ActiveRecord::Migration[5.2]
  def change
    create_table :challenges do |t|
      t.integer :sub1
      t.integer :sub2
      t.integer :status
      t.text :log

      t.timestamps
    end
  end
end
