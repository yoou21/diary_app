class Goal < ApplicationRecord
  belongs_to :user
  has_many :diaries, dependent: :destroy
  has_many :emotions, dependent: :destroy # 追加

  validates :title, presence: true
  validates :status, inclusion: { in: ["未達成", "達成済み"] }
  validates :deadline, presence: true

  after_create :create_emotion_data_for_goal

  private

  def create_emotion_data_for_goal
    return unless self.user

    emotions = ['喜び', '悲しみ', '不安', '楽しみ']  # 使用する感情のリスト（必要に応じて変更）

    emotions.each do |emotion_word|
      # 既に感情が存在していれば追加しない
      unless self.emotions.exists?(word: emotion_word)
        Emotion.create!(
          user: self.user,
          goal_id: self.id,
          word: emotion_word,
          name: emotion_word,
          date: Date.today
        )
      end
    end
  end
end
