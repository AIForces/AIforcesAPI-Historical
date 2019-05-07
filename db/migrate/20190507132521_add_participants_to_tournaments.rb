class AddParticipantsToTournaments < ActiveRecord::Migration[5.2]
  def change
    add_column :tournaments, :participants, :text
  end
end
