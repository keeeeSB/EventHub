require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest

  test "新規登録ページの取得" do
    get signup_path
    assert_response :success
  end
end
