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
    message: "は8文字以上で、少なくとも1つの大文字と数字を含めてください"
  }, on: :create

  # 新しいユーザーが作成されたときにデフォルトの感情データを作成
  after_create :create_default_emotions

  private

  # デフォルトの感情データを作成
  def create_default_emotions
    Emotion.create!(name: '嬉しい', word: '喜び', score: 3, user_id: self.id, date: Date.today)
    Emotion.create!(name: '悲しい', word: '悲しみ', score: -1, user_id: self.id, date: Date.today)
    Emotion.create!(name: '楽しい', word: '楽しみ', score: 2, user_id: self.id, date: Date.today)
    Emotion.create!(name: '怒り', word: '怒り', score: -2, user_id: self.id, date: Date.today)
  end
end
