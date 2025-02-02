class Diary < ApplicationRecord
  belongs_to :goal
  belongs_to :user
  has_many :emotions, dependent: :destroy

  validates :content, presence: true
  validates :intensity, numericality: { only_integer: true, greater_than: -5, less_than_or_equal_to: 5 }
  validates :date, presence: true  # NULL を防ぐバリデーション

  before_save :calculate_emotion_score
  before_validation :set_default_date, on: :create  # デフォルトの日付をセット

  # 日記データをAPI用に取得するスコープ
  scope :recent_scores, -> { select(:created_at, :emotion_score).order(created_at: :asc) }

  private

  # 感情スコアの計算
  def calculate_emotion_score
    self.emotion_score = emotions.sum do |emotion|
      DictionaryEntry.find_by(word: emotion.word)&.score.to_i
    end
  end

  # 日記作成時に感情データを自動生成
  after_create :create_emotion_data

  def create_emotion_data
    emotion_words = ['喜び', '悲しみ', '不安', '楽しみ']  # 必要に応じて変更
    emotion_words.each do |word|
      self.emotions.create!(user: user, goal_id: goal_id, word: word, name: word, date: Date.today)
    end
  end

  # `date` が NULL の場合に `Date.today` を設定
  def set_default_date
    self.date ||= Date.today
  end
end
