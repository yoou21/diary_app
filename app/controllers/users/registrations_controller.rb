# app/controllers/users/registrations_controller.rb
class Users::RegistrationsController < Devise::RegistrationsController
  # Turboを無効にする
  respond_to :html

  protected

  # ユーザー登録後にログイン画面へリダイレクト
  def after_sign_up_path_for(resource)
    new_user_session_path  # ログイン画面のパス
  end

  # ユーザー登録後に自動ログインを無効にする
  def sign_up(resource_name, resource)
    # ログインせずに登録処理のみ
  end
end
