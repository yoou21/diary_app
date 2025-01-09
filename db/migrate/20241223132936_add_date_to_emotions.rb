class AddDateToEmotions < ActiveRecord::Migration[7.2]
  def change
    add_column :emotions, :date, :date
  end
end
