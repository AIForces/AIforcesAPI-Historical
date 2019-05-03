class AddAssociationToSubmissions < ActiveRecord::Migration[5.2]
  def change
    change_table :submissions do |t|
      t.belongs_to :user, index: true
    end
  end
end
