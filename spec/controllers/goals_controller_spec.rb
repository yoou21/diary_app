# spec/controllers/goals_controller_spec.rb
require 'rails_helper'

RSpec.describe GoalsController, type: :controller do
  let(:user) { create(:user) }
  let(:goal_params) { { title: "Test Goal", status: "未達成", deadline: Date.today + 7.days } }

  before do
    sign_in user  # Devise を使用している場合、ユーザーをサインインさせる
  end

  describe 'POST #create' do
    context '有効なパラメータの場合' do
      it '新しい Goal を作成すること' do
        expect {
          post :create, params: { goal: goal_params }
        }.to change(Goal, :count).by(1)
        expect(response).to redirect_to(dashboard_path)  # 目標が作成され、ダッシュボードにリダイレクトされることを確認
      end
    end

    context '無効なパラメータの場合' do
      it 'Goal を作成しないこと' do
        invalid_goal_params = goal_params.merge(title: nil)  # タイトルなしで送信
        expect {
          post :create, params: { goal: invalid_goal_params }
        }.to_not change(Goal, :count)
        expect(response).to render_template(:new)  # 新規作成フォームに戻ることを確認
      end
    end
  end
end
