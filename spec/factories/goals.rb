# spec/factories/goals.rb
FactoryBot.define do
  factory :goal do
    title { "Sample Goal" }
    status { "In Progress" }
    user  # user association を追加
  end
end
