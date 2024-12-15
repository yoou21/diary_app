class Goal < ApplicationRecord
  belongs_to :user
  has_many :diaries, dependent: :destroy

  validates :title, presence: true
  validates :status, inclusion: { in: ["未達成", "達成済み", "In Progress"] }
  validates :deadline, presence: true
end
