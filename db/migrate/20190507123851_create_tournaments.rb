class CreateTournaments < ActiveRecord::Migration[5.2]
  def change
    create_table :tournaments do |t|
      t.string :name
      t.integer :number_of_ch_per_pair

      t.timestamps
    end
  end
end
