require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:Keisuke)
  end

  test "新規登録ページの取得" do
    get signup_path
    assert_response :success
  end

  test "ユーザーページの取得" do
    get @user
    assert_response :success
  end
end
