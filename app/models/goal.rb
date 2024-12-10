class Goal < ApplicationRecord
  belongs_to :user

  validates :title, presence: true
  validates :status, inclusion: { in: ["未達成", "達成済み", "In Progress"] }  # "In Progress" を追加
  validates :deadline, presence: true
end
