require "test_helper"

class HomeControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    # root_url を使用するか、home_index_url を使用するか、プロジェクトに合わせて修正
    get root_url # または get home_index_url としても良い

    # レスポンスが成功していることを確認
    assert_response :success
  end
end
