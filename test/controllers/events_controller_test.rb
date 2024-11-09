require "test_helper"

class EventsControllerTest < ActionDispatch::IntegrationTest
  test "イベント一覧ページの取得" do
    get root_path
    assert_response :success
  end
end
