class AddUserIdToDiaries < ActiveRecord::Migration[7.2]
  def change
    add_column :diaries, :user_id, :integer
    add_foreign_key :diaries, :users, column: :user_id
    add_index :diaries, :user_id
  end
end
