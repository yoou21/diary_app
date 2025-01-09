class EmotionsController < ApplicationController
  def index
    # 現在の月の感情データを取得
    @emotions = Emotion.where(date: Date.today.beginning_of_month..Date.today.end_of_month)
  end
end