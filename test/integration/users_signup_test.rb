require "test_helper"

class UsersSignupTest < ActionDispatch::IntegrationTest
  test "ユーザー登録のテスト" do
    get signup_path
    assert_response :success

    assert_difference "User.count", 1 do
      post users_path, params: { user: { name: "Example User",
                                         email: "user@example.com",
                                         password: "password",
                                         password_confirmation: "password" } }
    end

    follow_redirect!
  end
end
