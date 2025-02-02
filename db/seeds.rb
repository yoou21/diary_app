# 辞書データのリスト
dictionary_entries = [
  { word: "成功", score: 3 },
  { word: "達成", score: 2 },
  { word: "挑戦", score: 1 },
  { word: "失敗", score: -2 },
  { word: "挫折", score: -3 }
]

# 辞書データをデータベースに登録（スコアも更新する場合）
dictionary_entries.each do |entry|
  dictionary_entry = DictionaryEntry.find_or_initialize_by(word: entry[:word])
  dictionary_entry.update!(score: entry[:score])
end

puts "辞書データを登録しました！"

# テストユーザーを検索、なければ作成
user = User.find_or_create_by!(email: 'test@example.com') do |u|
  u.password = 'Password123'  # パスワード設定
  u.password_confirmation = 'Password123'  # パスワード確認
end

puts "テストユーザーを登録しました！（#{user.email}）"