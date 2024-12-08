class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  # ログイン後にダッシュボードへリダイレクト
  def after_sign_in_path_for(resource)
    dashboard_path  # ダッシュボードのパスにリダイレクト
  end
end
