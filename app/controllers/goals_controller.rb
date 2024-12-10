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

  private

  def goal_params
    params.require(:goal).permit(:title, :status, :deadline)
  end
end
