FactoryBot.define do
  factory :goal do
    title { "Sample Goal" }
    deadline { Date.today + 7.days }
    status { "未達成" } # 有効なデフォルト値
    association :user # ユーザーとの関連付け
  end
end
