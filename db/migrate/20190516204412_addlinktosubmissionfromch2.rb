class Addlinktosubmissionfromch2 < ActiveRecord::Migration[5.2]
  def change
    remove_column :challenges, :submissions_id
    change_table :challenges do |t|
      t.belongs_to :submission
    end
  end
end
