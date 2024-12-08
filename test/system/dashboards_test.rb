# test/system/dashboards_test.rb
require "application_system_test_case"

class DashboardTest < ApplicationSystemTestCase
  setup do
    # ユーザーと目標を作成
    @user = User.create!(email: 'test@example.com', password: 'password123')
    @goal = Goal.create!(title: 'My First Goal', status: 'active', user_id: @user.id)
  end

  test 'ダッシュボード画面に目標が表示されること' do
    # サインイン（必要に応じてDeviseのヘルパーメソッドを使用）
    sign_in @user  # Deviseのテストヘルパーを使ってサインイン

    visit dashboard_path(@user)  # ダッシュボード画面にアクセス
    assert_text 'My First Goal'  # 目標のタイトルが表示されていることを確認
  end

  test '目標を追加できること' do
    sign_in @user  # サインイン

    visit dashboard_path(@user)  # ダッシュボード画面にアクセス

    # 目標を追加
    click_button '目標を追加'
    fill_in '目標名', with: '新しい目標'
    click_button '保存'

    # 目標が追加されたことを確認
    assert_text '新しい目標'  # 新しい目標のタイトルが表示されることを確認
  end
end
