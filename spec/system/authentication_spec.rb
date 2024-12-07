require 'rails_helper'

RSpec.describe 'Authentication', type: :system do
  before do
    driven_by(:selenium_chrome_headless)

    # テスト用ユーザーを作成
    @user = User.create!(
      email: 'test@example.com',
      password: 'password',
      password_confirmation: 'password'
    )
  end

  it 'ユーザーがログインしてログアウトする' do
    # トップページにアクセス
    visit root_path

    # ログインページに移動
    click_link 'ログイン'

    # ログインフォームを入力
    fill_in 'Email', with: @user.email
    fill_in 'Password', with: @user.password
    click_button 'ログイン'

    # ログイン成功の確認
    expect(page).to have_content('ログインしました')
    expect(page).to have_content('ログアウト')

    # ログアウトをクリック
    click_link 'ログアウト'

    # ログアウト成功の確認
    expect(page).to have_content('ログアウトしました')
    expect(page).to have_content('ログイン')
  end
end
