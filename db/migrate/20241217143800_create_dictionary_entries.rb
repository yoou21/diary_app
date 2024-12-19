class CreateDictionaryEntries < ActiveRecord::Migration[6.1]
  def change
    unless table_exists?(:dictionary_entries)
      create_table :dictionary_entries do |t|
        t.string :word
        t.integer :score
        t.timestamps
      end
    end
  end
end
