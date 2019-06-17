class ConnectTournamentsAndEvents < ActiveRecord::Migration[5.2]
  def change
    change_table :tournaments do |t|
      t.belongs_to :event
    end
  end
end
