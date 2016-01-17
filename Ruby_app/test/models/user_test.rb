require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    @user = User.new(username: "Example User", email: "user@example.com", password_digest: "123", password_confirmation: "123")
  end

  test "should be valid" do
    assert @user.valid?
  end
end
