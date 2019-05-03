class CreateSubmissions < ActiveRecord::Migration[5.2]
  def change
    create_table :submissions do |t|
      t.string :compiler
      t.text :code

      t.timestamps
    end
  end
end
