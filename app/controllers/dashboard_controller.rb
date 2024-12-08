class DashboardController < ApplicationController
  before_action :authenticate_user! # ユーザー認証が必要な場合

  def index
    @goals = current_user.goals # ログインしているユーザーの目標を取得
  end
end
