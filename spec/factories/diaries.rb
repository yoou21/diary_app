FactoryBot.define do
  factory :diary do
    content { "テスト日記" }
    emotion { "嬉しい" }
    intensity { 5 }
    association :goal
  end
end
