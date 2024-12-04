# test/controllers/home_controller_test.rb
require 'test_helper'

class HomeControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    # ユーザー作成
    user = User.create!(email: 'test@example.com', password: 'password')

    # ログイン
    login_as(user)

    # ホームページにアクセス
    get root_url
    assert_response :success  # ステータスコードが200 OKであることを確認
  end
end
