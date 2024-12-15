class Diary < ApplicationRecord
  belongs_to :goal

  validates :content, presence: true
  validates :emotion, presence: true
  validates :intensity, numericality: { only_integer: true, greater_than: 0, less_than_or_equal_to: 10 }
end
