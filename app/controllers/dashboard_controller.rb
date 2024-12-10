class DashboardController < ApplicationController
  before_action :authenticate_user! # ユーザー認証が必要な場合

  def index
    @goals = Goal.all
  end
end
