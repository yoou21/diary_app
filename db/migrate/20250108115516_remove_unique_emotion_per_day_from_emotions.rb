class RemoveUniqueEmotionPerDayFromEmotions < ActiveRecord::Migration[7.2]
  def change
    remove_index :emotions, name: 'unique_emotion_per_day'
  end
end
