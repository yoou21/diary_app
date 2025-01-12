class User < ApplicationRecord
  # Devise modules
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  # ユーザーは複数の目標を持つ
  has_many :goals
  has_many :diaries  # 追加
  has_many :emotions

  # パスワード強度のバリデーション
  validates :password, presence: true, length: { minimum: 8 }, format: {
  with: /\A(?=.*[A-Z])(?=.*\d).+\z/,
  message: I18n.t('activerecord.errors.models.user.attributes.password.invalid')
}, on: :create
end
