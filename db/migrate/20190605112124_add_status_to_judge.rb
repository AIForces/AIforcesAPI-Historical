class AddStatusToJudge < ActiveRecord::Migration[5.2]
  def change
    add_column :judges, :status, :string
  end
end
