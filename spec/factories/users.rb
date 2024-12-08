# spec/factories/users.rb
FactoryBot.define do
  factory :user do
    email { "user@example.com" }
    password { "Password123" }  # 8文字以上、大文字、数字を含むパスワード
    password_confirmation { "Password123" }  # 確認用パスワードも同様
  end
end
