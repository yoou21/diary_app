# app/models/diary_entry.rb
class DiaryEntry < ApplicationRecord
  validates :date, presence: true
  validates :emotion_score, presence: true

  scope :recent, -> { order(date: :asc) }
end
