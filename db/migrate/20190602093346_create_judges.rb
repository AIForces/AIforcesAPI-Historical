class CreateJudges < ActiveRecord::Migration[5.2]
  def change
    create_table :judges do |t|
      t.string :name
      t.string :ip

      t.timestamps
    end
  end
end
