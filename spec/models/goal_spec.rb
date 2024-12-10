# spec/models/goal_spec.rb
require 'rails_helper'

RSpec.describe Goal, type: :model do
  let(:user) { create(:user) }  # FactoryBot を使用してユーザーを作成
  let(:goal) { build(:goal, user: user) }  # Goal のファクトリを使用してインスタンスを作成

  it '有効なファクトリを作成する' do
    expect(goal).to be_valid
  end

  it 'タイトルがない場合、無効であること' do
    goal.title = nil
    expect(goal).to_not be_valid
  end

  it 'ステータスが「未達成」または「達成済み」以外の場合、無効であること' do
    goal.status = "進行中"
    expect(goal).to_not be_valid
  end

  it '締切日がない場合、無効であること' do
    goal.deadline = nil
    expect(goal).to_not be_valid
  end

  # データベースに保存されたGoalが作成されることを確認
  it 'ステータスが「未達成」または「達成済み」の場合は、データベースに保存されること' do
    goal.status = '未達成'
    expect { goal.save }.to change(Goal, :count).by(1)
  end
end
