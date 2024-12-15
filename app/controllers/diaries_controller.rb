class DiariesController < ApplicationController
  before_action :set_goal
  before_action :set_diary, only: [:show, :destroy]

  def index
    @diaries = @goal.diaries
  end

  def new
    @diary = @goal.diaries.new
  end

  def create
    @diary = @goal.diaries.new(diary_params)
    if @diary.save
      redirect_to goal_diaries_path(@goal), notice: "日記が保存されました。"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
  end

  def destroy
    @diary = @goal.diaries.find(params[:id])
    @diary.destroy
    redirect_to goal_path(@goal), notice: "日記が削除されました。"
  end

  private

  def set_goal
    Rails.logger.debug "PARAMS: #{params.inspect}" # デバッグ用
    @goal = Goal.find(params[:goal_id])
  rescue ActiveRecord::RecordNotFound
    Rails.logger.debug "Goal not found with ID: #{params[:goal_id]}"
    redirect_to goals_path, alert: "指定された目標は存在しません。"
  end

  def set_diary
    @diary = @goal.diaries.find(params[:id])
  end

  def diary_params
    params.require(:diary).permit(:content, :emotion, :intensity)
  end
end
