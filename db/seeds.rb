# db/seeds.rb
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

100.times do
  diary = Diary.new(
    date: Faker::Date.backward(days: rand(1..365)),
    emotion_data: ["喜び", "楽しい", "不安", "成功"].sample(2),  # ランダムな感情データを追加
    user_id: user.id  # ユーザーIDを関連付け
  )
  diary.calculate_emotion_score  # スコア計算
  diary.save  # Emotion score を計算し、保存
end
