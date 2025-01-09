class AddUserIdToEmotions < ActiveRecord::Migration[7.2]
  def change
    # すでにカラムが存在するため、何も変更を加えない
    puts "user_id column already exists in emotions table. Skipping migration."
  end
end