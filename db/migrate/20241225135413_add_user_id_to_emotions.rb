class AddUserIdToEmotions < ActiveRecord::Migration[7.2]
  def change
    add_reference :emotions, :user, foreign_key: true
  end
end