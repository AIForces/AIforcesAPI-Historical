class AddHiddenTournaments < ActiveRecord::Migration[5.2]
  def change
    add_column :tournaments, :hidden, :boolean
  end
end
