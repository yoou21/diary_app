class AddUserIdToEmotions < ActiveRecord::Migration[7.2]
  def change
    add_column :emotions, :user_id, :integer
    add_index :emotions, :user_id
  end
end
