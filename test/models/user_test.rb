require "test_helper"

class UserTest < ActiveSupport::TestCase

  def setup
    @user = User.new(name: "Example User", email: "user@example.com")
  end

  test "nameカラムのバリデーションのテスト" do
    @user.name = " "
    assert_not @user.valid?
  end

  test "emailカラムのバリデーションのテスト" do
    @user.email = " "
    assert_not @user.valid?
  end
end
