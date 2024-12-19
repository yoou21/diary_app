# spec/system/score_calculation_spec.rb

require 'rails_helper'

RSpec.describe "Score Calculation", type: :system do
  before do
    DictionaryEntry.create!(word: "成功", score: 3)
    DictionaryEntry.create!(word: "達成", score: 2)
    DictionaryEntry.create!(word: "失敗", score: -2)
  end

  it "calculates the score and displays the result" do
    visit goals_path
    fill_in "テキストを入力してください:", with: "成功 達成 失敗"
    click_button "スコアを計算"

    expect(page).to have_content("スコア: 3")
  end

  it "calculates a score of 0 for unknown words" do
    visit goals_path
    fill_in "テキストを入力してください:", with: "無関係"
    click_button "スコアを計算"

    expect(page).to have_content("スコア: 0")
  end
end
