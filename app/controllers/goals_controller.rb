class GoalsController < ApplicationController
  before_action :authenticate_user!

  def new
    @goal = Goal.new
  end

  def create
    @goal = current_user.goals.build(goal_params)
    if @goal.save
      redirect_to dashboard_path, notice: '目標が追加されました。'
    else
      render :new
    end
  end

  def index
    @goals = current_user.goals
    flash[:alert] = '目標がありません。' if @goals.empty?
  end

  def show
    @goal = current_user.goals.find_by(id: params[:id])
    if @goal.nil?
      redirect_to goals_path, alert: "指定された目標は存在しません。"
    end
  end

  def destroy
    @goal = current_user.goals.find(params[:id])
    if @goal.destroy
      redirect_to dashboard_path, notice: '目標が削除されました。'
    else
      redirect_to goals_path, alert: '目標の削除に失敗しました。'
    end
  end

  def score_calculation
    text = params[:text]
    service = DictionaryService.new(text)
    @score = service.calculate_score

    respond_to do |format|
      format.html { redirect_to goals_path, notice: "スコア: #{@score}" }
      format.json { render json: { score: @score } }
    end
  end

  private

  def goal_params
    params.require(:goal).permit(:title, :status, :deadline)
  end
end
