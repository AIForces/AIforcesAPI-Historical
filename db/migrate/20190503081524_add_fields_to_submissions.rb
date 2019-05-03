class AddFieldsToSubmissions < ActiveRecord::Migration[5.2]
  def change
    add_column :submissions, :status, :string
    add_column :submissions, :fav, :boolean
  end
end
