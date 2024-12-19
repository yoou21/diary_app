# spec/controllers/goals_controller_spec.rb
require 'rails_helper'

RSpec.describe GoalsController, type: :controller do
  let(:user) { create(:user) }
  let(:goal_params) { { title: "Test Goal", status: "未達成", deadline: Date.today + 7.days } }
  let!(:goal) { create(:goal, user: user) }

  before do
    sign_in user
  end

  describe 'POST #create' do
    context '有効なパラメータの場合' do
      it '新しい Goal を作成すること' do
        expect {
          post :create, params: { goal: goal_params }
        }.to change(Goal, :count).by(1)
        expect(response).to redirect_to(dashboard_path)
      end
    end

    context '無効なパラメータの場合' do
      it 'Goal を作成しないこと' do
        invalid_goal_params = goal_params.merge(title: nil)
        expect {
          post :create, params: { goal: invalid_goal_params }
        }.to_not change(Goal, :count)
        expect(response).to render_template(:new)
      end
    end
  end

  describe "POST #score_calculation" do
    before do
      DictionaryEntry.create!(word: "成功", score: 3)
      DictionaryEntry.create!(word: "達成", score: 2)
      DictionaryEntry.create!(word: "失敗", score: -2)
    end

    it "calculates the correct score and redirects to goals_path" do
      post :score_calculation, params: { text: "成功 達成 失敗" }
      expect(response).to redirect_to(goals_path)
      expect(flash[:notice]).to eq("スコア: 3")
    end

    it "calculates a score of 0 for unknown words" do
      post :score_calculation, params: { text: "無関係" }
      expect(response).to redirect_to(goals_path)
      expect(flash[:notice]).to eq("スコア: 0")
    end
  end

  describe 'GET #show' do
    it '目標の詳細が表示されること' do
      get :show, params: { id: goal.id }
      expect(assigns(:goal)).to eq(goal)
      expect(response).to render_template(:show)
    end
  end

  describe 'DELETE #destroy' do
    it '目標が削除されること' do
      expect {
        delete :destroy, params: { id: goal.id }
      }.to change(Goal, :count).by(-1)
      expect(response).to redirect_to(dashboard_path)
      expect(flash[:notice]).to eq('目標が削除されました。')
    end
  end
end
