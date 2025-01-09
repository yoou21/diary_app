class AddNameToEmotions < ActiveRecord::Migration[7.2]
  def change
    add_column :emotions, :name, :string
  end
end
