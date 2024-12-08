require "test_helper"

class HomeControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    # GETリクエストで /home/index にアクセス
    get home_index_url
    # レスポンスが成功していることを確認
    assert_response :success
  end
end
