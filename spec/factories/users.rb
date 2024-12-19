FactoryBot.define do
  factory :user do
    email { "test@example.com" }
    password { "Password1" } # バリデーションを満たすパスワード
  end
end
