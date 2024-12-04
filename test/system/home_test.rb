require "application_system_test_case"

class HomeTest < ApplicationSystemTestCase
  test "visiting the home page and clicking buttons" do
    # ユーザーを作成
    user = User.create!(email: "test@example.com", password: "password")

    # ユーザーとしてログイン
    login_as(user)

    visit root_path  # トップページにアクセス

    # ユーザー登録ボタンが存在し、クリックで'/signup'に遷移することを確認
    assert_selector "a", text: "Sign Up"
    click_on "Sign Up"
    assert_current_path signup_path

    # ログインボタンが存在し、クリックで'/login'に遷移することを確認
    visit root_path
    assert_selector "a", text: "Login"
    click_on "Login"
    assert_current_path login_path
  end
end