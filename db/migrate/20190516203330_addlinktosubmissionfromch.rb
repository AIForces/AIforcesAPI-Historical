class Addlinktosubmissionfromch < ActiveRecord::Migration[5.2]
  def change
    change_table :challenges do |t|
      t.belongs_to :submissions
    end
  end
end
