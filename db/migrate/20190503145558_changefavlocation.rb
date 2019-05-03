class Changefavlocation < ActiveRecord::Migration[5.2]
  def change
    remove_column :submissions, :fav
    add_column :users, :fav_id, :integer
  end
end
