class AddDeadlineColumnToGoals < ActiveRecord::Migration[7.2]
  def change
    # すでにカラムが存在する場合は何もしない
    add_column :goals, :deadline, :date unless column_exists?(:goals, :deadline)
  end
end