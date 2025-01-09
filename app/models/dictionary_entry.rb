class DictionaryEntry < ApplicationRecord
  validates :word, presence: true, uniqueness: true
  validates :score, numericality: true
end