class AddDeadlineToGoals < ActiveRecord::Migration[7.2]
  def change
    add_column :goals, :deadline, :date
  end
end
