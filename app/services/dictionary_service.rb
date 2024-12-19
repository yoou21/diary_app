class DictionaryService
  def initialize(text)
    @text = text
    @dictionary = DictionaryEntry.all
  end

  # テキストを分割し、辞書と照合してスコア計算
  def calculate_score
    words = @text.split(/[\s　,、.。]/) # 句読点やスペースで分割
    score = 0

    words.each do |word|
      entry = @dictionary.find_by(word: word)
      score += entry.score if entry
    end

    score
  end
end
