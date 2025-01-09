class AddEmotionScoreToDiary < ActiveRecord::Migration[7.2]
  def change
    add_column :diaries, :emotion_score, :integer, default: 0
    add_column :diaries, :emotion_data, :text, array: true, default: []
  end
end
