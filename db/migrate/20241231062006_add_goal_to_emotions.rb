class AddGoalToEmotions < ActiveRecord::Migration[7.2]
  def change
    # goal_id カラムを null: true で追加
    add_reference :emotions, :goal, null: true, foreign_key: true
  end
end