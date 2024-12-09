# spec/requests/dashboard_spec.rb
require 'rails_helper'

RSpec.describe "Dashboard", type: :request do
  let(:user) { create(:user) }
  let!(:goal) { create(:goal, user: user, title: 'Learn Ruby', status: '未達成') }  # '未達成' に変更

  before do
    sign_in user
  end

  it "GET /dashboard when user is logged in when there are goals displays the user's goals" do
    get dashboard_path

    # goal.title と goal.status が HTML 内に含まれていることを確認
    expect(response.body).to include('Learn Ruby')  # タイトルが表示されていること
    expect(response.body).to include('未達成')  # ステータスが表示されていること
  end
end
