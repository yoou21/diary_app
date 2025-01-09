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
    # 現在のユーザーの目標を取得
    @goals = current_user.goals

    # もし目標がない場合の処理
    if @goals.empty?
      flash[:alert] = '目標がありません。'
    end
  end

  def show
    logger.debug "Params ID: #{params[:id]}"
    @goal = Goal.find_by(id: params[:id])
    if @goal.nil?
      redirect_to goals_path, alert: "指定された目標は存在しません。"
    end
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
