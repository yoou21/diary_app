class Diary < ApplicationRecord
  belongs_to :goal
  belongs_to :user
  has_many :emotions, dependent: :destroy

  validates :content, presence: true
  validates :intensity, numericality: { only_integer: true, greater_than: -5, less_than_or_equal_to: 5 }

  # 日記作成時に感情データを作成
  after_create :create_emotion_data

  # 感情スコアを計算するメソッド
  def calculate_emotion_score
    total_score = 0

    # emotion_dataに含まれる感情に基づいてスコアを加算
    self.emotions.each do |emotion|
      # DictionaryEntryからスコアを取得して加算
      entry = DictionaryEntry.find_by(word: emotion.word)
      total_score += entry.score if entry
    end

    # 計算したスコアをDiaryのフィールドに保存
    self.update(emotion_score: total_score)
  end

  private

  def create_emotion_data
    emotions = ['喜び', '悲しみ', '不安', '楽しみ']  # 使用する感情のリスト（必要に応じて変更）

    emotions.each do |emotion_word|
      # Emotionモデルに感情データを作成
      emotion = Emotion.create!(user: self.user, goal_id: self.goal_id, word: emotion_word, name: emotion_word, date: Date.today)
      self.emotions << emotion # 作成した感情を日記に関連づける
    end

    # 作成後にスコアを計算
    calculate_emotion_score
  end
end