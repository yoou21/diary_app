FactoryBot.define do
  factory :goal do
    title { "テスト目標" }
    status { "未達成" }
    deadline { Date.today + 7.days }
    association :user
  end
end
