# spec/factories/goals.rb
FactoryBot.define do
  factory :goal do
    title { 'Test Goal' } # タイトル
    status { '未達成' } # ステータス
    deadline { Date.today + 7.days }   # 締切日（現在日から7日後）
    association :user                  # User モデルとのアソシエーション（関連付け）
  end
end
