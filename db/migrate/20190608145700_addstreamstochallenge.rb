class Addstreamstochallenge < ActiveRecord::Migration[5.2]
  def change
    add_column :challenges, :streams, :text
  end
end
