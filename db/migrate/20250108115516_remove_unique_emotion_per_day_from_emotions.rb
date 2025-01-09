class RemoveUniqueEmotionPerDayFromEmotions < ActiveRecord::Migration[7.2]
  def change
    remove_index :emotions, column: [:user_id, :created_at]
  end
end
