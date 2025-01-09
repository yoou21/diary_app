class CreateEmotions < ActiveRecord::Migration[7.2]
  def change
    create_table :emotions do |t|
      t.string :word
      t.integer :score
      t.references :diary, null: true, foreign_key: true  # null: true に変更
      t.references :user, null: false, foreign_key: true  # user_id を追加

      t.timestamps
    end
  end
end
