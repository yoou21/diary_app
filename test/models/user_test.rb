require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "should not save user without email" do
    user = User.new(email: nil)
    assert_not user.save, "Saved the user without an email"
  end

  test "should save user with valid email" do
    user = User.new(email: "valid@example.com", password: "password123")
    assert user.save, "Failed to save the user with valid email"
  end
end
