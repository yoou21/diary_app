class ChangeDiaryIdToBeOptionalInEmotions < ActiveRecord::Migration[7.2]
  def change
    change_column_null :emotions, :diary_id, true
  end
end
