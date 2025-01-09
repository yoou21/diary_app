class ChangeGoalIdInEmotions < ActiveRecord::Migration[7.2]
  def change
    change_column_null :emotions, :goal_id, false
  end
end