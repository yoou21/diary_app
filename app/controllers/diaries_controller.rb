class DiariesController < ApplicationController
  before_action :authenticate_user!  # ユーザー認証
  before_action :set_goal, only: [:new, :create, :index]
  before_action :set_diary, only: [:show, :destroy]

  # 日記の一覧表示
  def index
    @goal = Goal.find(params[:goal_id])
    @diaries = @goal.diaries.where(user_id: current_user.id)
    @emotions_by_date = Emotion.where(user_id: current_user.id).group_by(&:date)
  end

  # 日記の新規作成ページ
  def new
    @diary = Diary.new
    @goal = Goal.find(params[:goal_id])
    @emotions = Emotion.where(user_id: current_user.id, goal_id: @goal.id) # 感情データ取得
    puts @emotions.inspect  # デバッグ用
  end

  # 日記の作成処理
  def create
    @diary = @goal.diaries.new(diary_params)
    @diary.user = current_user

    emotion = Emotion.find_by(id: params[:diary][:emotion_id])

    if emotion.present? && !@diary.emotions.exists?(id: emotion.id)
      @diary.emotions << emotion
      emotion.update(diary_id: @diary.id)
    end

    if @diary.save
      redirect_to goal_diaries_path(@goal), notice: '日記が作成されました。'
    else
      render :new
    end
  end

  # 日記の詳細表示
  def show
    @goal = Goal.find_by(id: params[:goal_id])

    if @goal.nil?
      redirect_to goals_path, alert: "指定された目標は存在しません。"
      return
    end

    @diary = @goal.diaries.find_by(id: params[:id])

    if @diary.nil?
      redirect_to goal_diaries_path(@goal), alert: "指定された日記は存在しません。"
    end
  end

  # 感情スコアをJSON形式で提供（Chart.js用）
  def emotion_scores
    diaries = current_user.diaries.order(created_at: :asc)
    render json: diaries.map { |d| { date: d.created_at.strftime('%Y-%m-%d'), score: d.emotion_score } }
  end

  def destroy
    @diary = Diary.find_by(id: params[:id], goal_id: params[:goal_id])

    if @diary.nil?
      redirect_to goal_diaries_path(params[:goal_id]), alert: "日記が見つかりません。"
    else
      @diary.destroy
      redirect_to goal_diaries_path(params[:goal_id]), notice: "日記が削除されました。"
    end
  end

  private

  def set_goal
    @goal = Goal.find(params[:goal_id])
  end

  def set_diary
    @diary = @goal.diaries.find_by(id: params[:id])
  end

  def diary_params
    params.require(:diary).permit(:content, :intensity, :emotion_score)
  end
end
