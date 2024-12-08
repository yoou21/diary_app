# spec/requests/dashboard_spec.rb
RSpec.describe 'Dashboard', type: :request do
  let(:user) { create(:user) }

  describe 'GET /dashboard' do
    context 'when user is logged in' do
      before do
        sign_in user
      end

      context 'when there are no goals' do
        it 'displays the correct content when there are no goals' do
          get dashboard_path
          expect(response.body).to include('ダッシュボード')  # 正しいタイトルが表示されることを確認
          expect(response.body).to include('目標はありません。')  # 目標がない場合のメッセージ確認
        end
      end

      context 'when there are goals' do
        let!(:goal) { create(:goal, user: user, title: 'Learn Ruby', status: 'In Progress') }

        it 'displays the user\'s goals' do
          get dashboard_path
          expect(response.body).to include('Learn Ruby')  # ユーザーの目標が表示されることを確認
          expect(response.body).to include('In Progress')  # 目標のステータスが表示されることを確認
        end
      end
    end
  end
end
