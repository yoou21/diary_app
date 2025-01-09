class AddUniqueIndexToEmotions < ActiveRecord::Migration[7.0]
  def change
    add_index :emotions, [:user_id, :date, :name], unique: true, name: 'unique_emotion_per_day'
  end
end