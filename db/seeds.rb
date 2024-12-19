# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
# db/seeds.rb
DictionaryEntry.find_or_create_by!(word: "成功", score: 3)
DictionaryEntry.find_or_create_by!(word: "達成", score: 2)
DictionaryEntry.find_or_create_by!(word: "挑戦", score: 1)
DictionaryEntry.find_or_create_by!(word: "失敗", score: -2)
DictionaryEntry.find_or_create_by!(word: "挫折", score: -3)
