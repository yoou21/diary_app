class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  # ログイン後にダッシュボードへリダイレクト
  def after_sign_in_path_for(resource)
    flash[:notice] = t('devise.sessions.signed_in')  # ログイン成功時のフラッシュメッセージ
    dashboard_path  # ダッシュボードのパスにリダイレクト
  end

  # ログアウト後のリダイレクト
  def after_sign_out_path_for(resource_or_scope)
    flash[:notice] = t('devise.sessions.signed_out')  # ログアウト成功時のフラッシュメッセージ
    root_path  # ホームページにリダイレクト
  end

  # 🔧 ユーザー登録後にログイン画面へリダイレクト
  def after_sign_up_path_for(resource)
    flash[:notice] = t('devise.registrations.signed_up')  # 登録成功時のフラッシュメッセージ
    new_user_session_path  # ログイン画面へリダイレクト
  end
end
