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

  # Turbo Streams 対応のフラッシュメッセージをレンダリング
  after_action :flash_to_turbo_stream, if: -> { request.format.turbo_stream? && !devise_controller? }

  private

  # Turbo Stream でフラッシュメッセージを HTML 文字列として直接返す
  def flash_to_turbo_stream
    return unless flash.any?
    return if performed?  # すでにレンダリングされている場合は何もしない

    flash_html = flash.map do |key, message|
      view_context.tag.div(message, class: "flash-message flash-#{key}")
    end.join

    render turbo_stream: turbo_stream.update('flash-messages', html: flash_html)
    flash.discard
  end
end
