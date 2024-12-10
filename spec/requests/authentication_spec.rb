# spec/requests/authentication_spec.rb
require 'rails_helper'

RSpec.describe 'Authentication', type: :request do
  let(:user) { create(:user) }  # FactoryBotでユーザーを作成

  describe 'POST /users/sign_in' do
    it 'logs the user in with valid credentials' do
      post user_session_path, params: { user: { email: user.email, password: user.password } }

      expect(response).to redirect_to(dashboard_path)
      follow_redirect!
      expect(response.body).to include('Signed in successfully.')
    end

    it 'does not log the user in with invalid credentials' do
      post user_session_path, params: { user: { email: user.email, password: 'wrongpassword' } }

      expect(response).to have_http_status(:unprocessable_entity)
      expect(response.body).to include('Invalid Email or password.')  # フラッシュメッセージを確認
    end
  end

  describe 'DELETE /users/sign_out' do
    it 'logs the user out' do
      sign_in user

      delete destroy_user_session_path

      expect(response).to redirect_to(root_path)
      follow_redirect!
      expect(response.body).to include('Signed out successfully.')
    end
  end
end
