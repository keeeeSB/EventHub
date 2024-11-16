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
    assert_match "プロフィール", response.body
  end

  test "ログアウト機能のテスト" do
    log_in_as(@user)
    assert_redirected_to @user
    follow_redirect!

    delete logout_path(@user)
    assert_redirected_to root_path
    follow_redirect!

    assert_match "ログイン", response.body
  end
end
