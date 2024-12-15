require 'rails_helper'

RSpec.describe DiariesController, type: :controller do
  let(:user) { create(:user) } # ユーザーを作成
  let!(:goal) { create(:goal, user: user) } # 保存済みのgoalを作成
  let!(:diary) { create(:diary, goal: goal) } # 保存済みのdiaryを作成

  before do
    sign_in user # Devise ユーザー認証
  end

  describe 'DELETE #destroy' do
    it '日記が正常に削除されること' do
      expect {
        delete :destroy, params: { goal_id: goal.id, id: diary.id }
      }.to change(Diary, :count).by(-1)

      expect(response).to redirect_to(goal_path(goal))
      expect(flash[:notice]).to eq '日記が削除されました。'
    end

    it '存在しない日記IDでエラーが発生すること' do
      expect {
        delete :destroy, params: { goal_id: goal.id, id: 'non-existent' }
      }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
