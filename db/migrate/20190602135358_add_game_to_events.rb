class AddGameToEvents < ActiveRecord::Migration[5.2]
  def change
    change_table :events do |t|
      t.belongs_to :game, index: true
    end
  end
end
