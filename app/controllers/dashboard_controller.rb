class DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    # 目標と感情データを一緒にロード
    @goals = current_user.goals.includes(:emotions)

    # 選択された目標、または最初の目標を設定
    @goal = @goals.find_by(id: params[:goal_id]) || @goals.first

    # 目標が見つからない場合、エラーメッセージを表示してリダイレクト
    if @goal.nil?
      flash[:alert] = '目標が見つかりませんでした。'
      redirect_to goals_path
      return
    end

    # 目標に関連する感情データを取得（現在月）
    @emotions = Emotion.for_current_month(@goal.id, current_user.id)

    # 日付ごとに感情をグループ化
    @emotions_by_date = @emotions.group_by(&:date)
  end

  def create
    @diary = Diary.new(diary_params)
    @diary.user = current_user

    # 感情IDが選ばれていれば、その感情を日記に関連付け
    @diary.emotion_id = params[:diary][:emotion_id] if params[:diary][:emotion_id].present?

    if @diary.save
      redirect_to goal_diaries_path(@diary.goal), notice: '日記が作成されました'
    else
      render :new
    end
  end

  private

  def diary_params
    params.require(:diary).permit(:content, :emotion_id, :goal_id)
  end
end
