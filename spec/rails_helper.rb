require 'capybara/rspec'
require 'selenium-webdriver'

# Chromium 用のドライバーを登録
Capybara.register_driver :selenium_chrome_headless do |app|
  options = Selenium::WebDriver::Chrome::Options.new

  # Chromium のパスを指定
  options.binary = '/usr/bin/chromium'

  # ヘッドレスモードとその他のオプションを設定
  options.add_argument('--headless')
  options.add_argument('--disable-gpu')
  options.add_argument('--no-sandbox')
  options.add_argument('--disable-dev-shm-usage')
  options.add_argument('--window-size=1920,1080')

  Capybara::Selenium::Driver.new(
    app,
    browser: :chrome,
    options: options
  )
end

Capybara.javascript_driver = :selenium_chrome_headless

# RSpec の設定
RSpec.configure do |config|
  config.before(:each, type: :system) do
    driven_by :selenium_chrome_headless
  end
end
