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

  # 新しいユーザーが作成されたときにデフォルトの感情データを作成
  after_create :create_default_emotions

  private

  # デフォルトの感情データを作成
  def create_default_emotions
    # デフォルトのGoalを作成
    default_goal = goals.create!(title: "Default Goal", status: "未達成", deadline: Date.today + 30.days)

    # Goalを関連付けてEmotionを作成
    emotions.create!(name: '嬉しい', word: '喜び', score: 3, date: Date.today, goal: default_goal)
    emotions.create!(name: '悲しい', word: '悲しみ', score: -1, date: Date.today, goal: default_goal)
    emotions.create!(name: '楽しい', word: '楽しみ', score: 2, date: Date.today, goal: default_goal)
    emotions.create!(name: '怒り', word: '怒り', score: -2, date: Date.today, goal: default_goal)
  end
end
