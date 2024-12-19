require 'rails_helper'

RSpec.describe 'goals/index', type: :view do
  let(:user) { create(:user) } # テスト用ユーザー
  let(:goal) { create(:goal, title: 'Test Goal', user: user, status: '未達成') }

  before do
    assign(:goals, [goal])
  end

  it 'displays the text input form for score calculation' do
    render
    expect(rendered).to have_selector('textarea[placeholder="ここにテキストを入力..."]')
  end
end
