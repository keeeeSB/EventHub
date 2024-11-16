require "test_helper"

class EventCreationTest < ActionDispatch::IntegrationTest

  def setup
    @user     = users(:Keisuke)
    @category = categories(:sports)
  end

  test "イベント作成のテスト" do
    log_in_as(@user)
    assert_redirected_to @user
    follow_redirect!

    get new_user_event_path(@user)
    assert_response :success

    assert_difference "Event.count", 1 do
      post user_events_path(@user), params: { event: { title: "テストイベント",
                                                       description: "テストイベントです。",
                                                       start_time: 2.days.from_now,
                                                       location: "カフェ",
                                                       category_id: @category.id } }
      assert_redirected_to root_path
      follow_redirect!
      assert_match "テストイベント", response.body
    end
  end
end
