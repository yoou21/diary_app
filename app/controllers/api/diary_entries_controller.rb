class Api::DiaryEntriesController < ApplicationController
  def index
    diaries = Diary
      .where.not(emotion_score: 0)  # `emotion_score = 0` のデータを除外
      .order(date: :desc)

    render json: diaries.map { |diary|
      {
        date: diary.date.strftime("%Y-%m-%d"),  # `created_at` ではなく `date` を使用
        goal_id: diary.goal_id,  # `goal_id` も返す
        emotion_score: diary.emotion_score
      }
    }
  end

  def emotion_summary
    summary = {
      "ポジティブ" => Diary.where("emotion_score > 0").count,
      "ネガティブ" => Diary.where("emotion_score < 0").count
    }
    render json: summary
  end
end
