# spec/features/goals_spec.rb

require 'rails_helper'

RSpec.feature "Goal Management", type: :feature do
  let(:user) { create(:user) }  # ユーザーを作成
  let!(:goal) { create(:goal, user: user) }  # ユーザーに紐づく目標を作成

  before do
    sign_in user  # Deviseを使用している場合、ユーザーをサインインさせる
  end

  scenario '目標の詳細ページにアクセスし、日記を追加するリンクが表示されること' do
    visit goal_path(goal)  # 目標詳細ページに遷移
    expect(page).to have_link('日記を追加', href: new_goal_diary_path(goal_id: goal.id))  # リンクが正しく表示されること
    click_link '日記を追加'  # リンクをクリック
    expect(current_path).to eq(new_goal_diary_path(goal_id: goal.id))  # 日記作成ページに遷移すること
  end

  scenario '目標を作成することができる' do
    visit new_goal_path  # 新しい目標作成ページに遷移

    # 正しいフィールド名やラベルを指定する
    fill_in 'タイトル', with: '新しい目標' # タイトルを入力
    fill_in '締切日', with: (Date.today + 7.days).to_s  # 締切日を入力
    select '未達成', from: '目標の状態'  # ステータスを選択
    click_button '目標を追加する'  # 送信ボタンをクリック

    expect(page).to have_content('新しい目標')  # 作成した目標がページに表示されること
    expect(current_path).to eq(dashboard_path)  # ダッシュボードにリダイレクトされること
  end

  scenario '目標を削除することができる' do
    visit goal_path(goal)  # 目標詳細ページに遷移
    click_link '削除'  # 削除リンクをクリック

    expect(page).to_not have_content(goal.title)  # 目標がページに表示されなくなること
    expect(current_path).to eq(dashboard_path)  # ダッシュボードにリダイレクトされること
  end
end
