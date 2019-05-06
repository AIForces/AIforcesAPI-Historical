class Addnametosubmission < ActiveRecord::Migration[5.2]
  def change
    add_column :submissions, :name, :string
  end
end
