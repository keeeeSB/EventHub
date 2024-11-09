require "test_helper"

class EventsControllerTest < ActionDispatch::IntegrationTest
  test "イベント一覧ページの取得" do
    get events_path
    assert_response :success
  end

  test "イベント作成ページの取得" do
    get new_user_event_path
    assert_response :success
  end
end
