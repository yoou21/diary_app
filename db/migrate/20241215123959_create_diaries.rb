class CreateDiaries < ActiveRecord::Migration[7.2]
  def change
    create_table :diaries, if_not_exists: true do |t|
      t.text :content
      t.string :emotion
      t.integer :intensity
      t.references :goal, null: false, foreign_key: true

      t.timestamps
    end
  end
end
