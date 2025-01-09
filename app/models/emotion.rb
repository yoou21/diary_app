class Emotion < ApplicationRecord
  belongs_to :user
  belongs_to :goal
  belongs_to :diary, optional: true  # Optional relationship with Diary

  validates :word, presence: true
  validates :name, presence: true
  validates :user, presence: true
  validates :goal, presence: true
  validates :user_id, :goal_id, :name, :date, presence: true
  validates :name, uniqueness: { scope: [:user_id, :goal_id, :date], message: "同じ感情はすでに登録されています。" }

  # Scope to filter emotions for the current month for a specific goal and user
  scope :for_current_month, ->(goal_id, user_id) {
    where(goal_id: goal_id, user_id: user_id, date: Date.today.beginning_of_month..Date.today.end_of_month)
  }

  # Method to determine the background color based on the emotion's name
  def emotion_color
    case name
    when "嬉しい"
      "#ffeb3b" # Yellow
    when "悲しい"
      "#2196f3" # Blue
    when "楽しい"
      "#4caf50" # Green
    when "怒り"
      "#f44336" # Red
    else
      "#ffffff" # Default (White)
    end
  end
end
