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

  private

  def goal_params
    params.require(:goal).permit(:title, :status, :deadline)
  end
end
