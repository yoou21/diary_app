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
    @goals = Goal.all
  end

  def show
    @goal = Goal.find(params[:id])
  end

  def destroy
    @goal = current_user.goals.find(params[:id])
    @goal.destroy
    redirect_to dashboard_path, notice: '目標が削除されました。'
  end

  def score_calculation
    text = params[:text] # 入力されたテキストを受け取る
    service = DictionaryService.new(text) # 辞書サービスでスコア計算
    @score = service.calculate_score # スコアをインスタンス変数に代入

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
