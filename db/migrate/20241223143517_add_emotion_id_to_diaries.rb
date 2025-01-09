class AddEmotionIdToDiaries < ActiveRecord::Migration[7.2]
  def change
    add_column :diaries, :emotion_id, :integer
  end
end
