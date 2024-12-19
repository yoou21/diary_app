require 'rails_helper'

RSpec.describe DictionaryService, type: :service do
  let!(:entry1) { DictionaryEntry.create!(word: "成功", score: 3) }
  let!(:entry2) { DictionaryEntry.create!(word: "達成", score: 2) }
  let!(:entry3) { DictionaryEntry.create!(word: "失敗", score: -2) }

  describe "#calculate_score" do
    it "calculates the correct score for given text" do
      text = "成功 達成 挑戦 失敗"
      service = DictionaryService.new(text)
      expect(service.calculate_score).to eq(3 + 2 + 0 - 2) # 成功(3) + 達成(2) + 失敗(-2)
    end

    it "returns 0 if no words match the dictionary" do
      text = "無関係のテキスト"
      service = DictionaryService.new(text)
      expect(service.calculate_score).to eq(0)
    end
  end
end
