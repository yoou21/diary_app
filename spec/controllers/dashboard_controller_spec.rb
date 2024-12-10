require 'rails_helper'

RSpec.describe DashboardController, type: :controller do
  let(:user) { create(:user) }  # FactoryBotを使用してユーザーを作成
  let!(:goal) { create(:goal, user: user) }  # ユーザーに紐づく目標を作成

  before do
    sign_in user  # ログインする（Deviseを使用している場合）
  end

  describe 'GET #index' do
    it 'ログインユーザーの目標が表示されること' do
      get :index
      expect(assigns(:goals)).to eq([goal])  # @goalsが正しくセットされていること
      expect(response).to render_template(:index)  # indexテンプレートが描画されること
    end
  end
end