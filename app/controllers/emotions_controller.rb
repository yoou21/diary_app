class EmotionsController < ApplicationController
  before_action :authenticate_user!

  def index
    # 現在のユーザーの現在月の感情データを取得
    @emotions = current_user.emotions.where(date: Date.today.beginning_of_month..Date.today.end_of_month)
  end

  def create
    # 特定の感情データを取得 or 初期化
    @emotion = current_user.emotions.find_or_initialize_by(date: params[:emotion][:date], name: params[:emotion][:name])

    # スコアの更新
    @emotion.score = params[:emotion][:score]

    if @emotion.save
      flash[:notice] = "感情を記録しました。"
      redirect_to dashboard_path
    else
      flash[:alert] = "感情の記録に失敗しました。"
      render :new
    end
  end
end
