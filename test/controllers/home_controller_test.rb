require "test_helper"

class HomeControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get root_url # URL を `home_index_url` から `root_url` に変更（適宜修正）
    assert_response :success
  end
end
