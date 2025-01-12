# 辞書データの作成
DictionaryEntry.find_or_create_by!(word: "成功", score: 3)
DictionaryEntry.find_or_create_by!(word: "達成", score: 2)
DictionaryEntry.find_or_create_by!(word: "挑戦", score: 1)
DictionaryEntry.find_or_create_by!(word: "失敗", score: -2)
DictionaryEntry.find_or_create_by!(word: "挫折", score: -3)

# 既存のユーザーを検索、なければ作成
user = User.find_or_create_by!(email: 'test@example.com') do |u|
  u.password = 'Password123'  # パスワード設定
  u.password_confirmation = 'Password123'  # パスワード確認
end