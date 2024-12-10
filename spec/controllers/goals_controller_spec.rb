# spec/controllers/goals_controller_spec.rb

require 'rails_helper'

RSpec.describe GoalsController, type: :controller do
  let(:user) { create(:user) }  # FactoryBotでユーザーを作成
  let(:goal_params) { { title: "Test Goal", status: "未達成", deadline: Date.today + 7.days } }
  let!(:goal) { create(:goal, user: user) }  # ユーザーに紐づく目標を作成

  before do
    sign_in user  # ログインする（Deviseを使用している場合）
  end

  # POST #create のテスト
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

  # GET #show のテスト
  describe 'GET #show' do
    it '目標の詳細が表示されること' do
      get :show, params: { id: goal.id }
      expect(assigns(:goal)).to eq(goal)  # @goalが正しくセットされていること
      expect(response).to render_template(:show)  # showテンプレートが描画されること
    end
  end

  # DELETE #destroy のテスト
  describe 'DELETE #destroy' do
    it '目標が削除されること' do
      expect {
        delete :destroy, params: { id: goal.id }
      }.to change(Goal, :count).by(-1)  # 目標の件数が1件減ること
      expect(response).to redirect_to(dashboard_path)  # ダッシュボードにリダイレクトされること
      expect(flash[:notice]).to eq('目標が削除されました。')  # フラッシュメッセージが表示されること
    end
  end
end
