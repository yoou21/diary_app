class CreateDictionaryEntries < ActiveRecord::Migration[7.2]
  def change
    create_table :dictionary_entries do |t|
      t.string :word
      t.integer :score

      t.timestamps
    end
  end
end
