class RemoveUniqueEmotionPerDayFromEmotions < ActiveRecord::Migration[7.2]
  def change
    remove_index :emotions, name: "index_emotions_on_goal_id", if_exists: true
  end
end