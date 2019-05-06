class Addnewfavtosubmissions < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :fav_id
    add_column :users, :fav_ch_id, :integer
    add_column :users, :fav_tours_id, :integer
    add_column :submissions, :used_for_ch, :boolean
    add_column :submissions, :used_for_tours, :boolean
  end
end
