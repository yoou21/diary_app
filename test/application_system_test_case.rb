require "test_helper"
require "database_cleaner/active_record" # DatabaseCleaner を正しく読み込み

# DatabaseCleaner の設定
DatabaseCleaner.strategy = :truncation
DatabaseCleaner.allow_remote_database_url = true

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  driven_by :selenium, using: :headless_chrome, screen_size: [1400, 1400]

  setup do
    DatabaseCleaner.start
  end

  teardown do
    DatabaseCleaner.clean
  end
end
