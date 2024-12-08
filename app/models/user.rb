# app/models/user.rb
class User < ApplicationRecord
  # Devise modules
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  # パスワード強度のバリデーション
  validates :password, presence: true, length: { minimum: 8 }, format: {
    with: /\A(?=.*[A-Z])(?=.*\d).+\z/,
    message: "は8文字以上で、少なくとも1つの大文字と数字を含めてください"
  }, on: :create
end
