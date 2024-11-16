require "test_helper"

class LoginTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:Keisuke)
  end

  test "ログイン機能のテスト" do
    get login_path
    assert_response :success

    post login_path, params: { session: { email:    @user.email,
                                          password: 'password' } }

    assert_redirected_to @user
    follow_redirect!
  end
end
