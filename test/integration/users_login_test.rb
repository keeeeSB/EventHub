require "test_helper"

class LoginTest < ActionDispatch::IntegrationTest

  test "ログイン機能のテスト" do
    get login_path
    post login_path, params: { session: { email: " ", password: " " } }
    assert_not flash.empty?
    get root_path
    assert flash.empty?
  end
end
