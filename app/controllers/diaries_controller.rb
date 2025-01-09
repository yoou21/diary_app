class DiariesController < ApplicationController
  before_action :authenticate_user!  # ユーザー認証
  before_action :set_goal, only: [:new, :create, :index]
  before_action :set_diary, only: [:show, :destroy]

  def index
    @goal = Goal.find(params[:goal_id])
    @diaries = @goal.diaries.where(user_id: current_user.id)
    @emotions_by_date = Emotion.where(user_id: current_user.id).group_by(&:date)
  end

  def new
    @diary = Diary.new
    @goal = Goal.find(params[:goal_id])
    @emotions = Emotion.where(user_id: current_user.id, goal_id: @goal.id) # 感情データ取得
    puts @emotions.inspect  # デバッグ用に感情データを表示
  end

  def create
    @diary = @goal.diaries.new(diary_params)
    @diary.user = current_user

    emotion = Emotion.find_by(id: params[:diary][:emotion_id])

    if emotion.present? && !@diary.emotions.include?(emotion)
      # 感情を新規に関連付け
      @diary.emotions << emotion
      # 感情にdiary_idを設定
      emotion.update(diary_id: @diary.id)
    end

    if @diary.save
      redirect_to goal_diaries_path(@goal), notice: '日記が作成されました。'
    else
      render :new
    end
  end

  def show
    @goal = Goal.find_by(id: params[:id])

    if @goal.nil?
      redirect_to goals_path, alert: "指定された目標は存在しません。"
      return
    end

    @diary = Diary.find_by(id: params[:id])  # ここで日記を取得
    @emotions = Emotion.where(date: Date.today.beginning_of_month..Date.today.end_of_month, user_id: current_user.id)
    @diaries = Diary.where(goal_id: @goal.id, user_id: current_user.id)
  end

  def destroy
    @goal = Goal.find(params[:goal_id])
    @diary = @goal.diaries.find(params[:id])  # Goalの中で特定のDiaryを探す

    # Diaryとその関連するEmotionを削除
    @diary.destroy

    redirect_to goal_diaries_path(@goal), notice: '日記が削除されました。'
  end

  private

  def set_goal
    @goal = Goal.find_by(id: params[:goal_id])
    if @goal.nil?
      redirect_to goals_path, alert: '指定された目標が見つかりませんでした。'
    end
  end

  def set_diary
    @diary = Diary.find(params[:id])
  end

  def diary_params
    params.require(:diary).permit(:content, :intensity, :emotion_id)
  end
end
