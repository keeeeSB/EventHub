require "test_helper"

class EventCreationTest < ActionDispatch::IntegrationTest

  def setup
    @user     = users(:Keisuke)
    @category = categories(:sports)
    @event    = events(:event)
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

  test "イベント編集のテスト" do
    log_in_as(@user)
    assert_redirected_to @user
    follow_redirect!

    get edit_user_event_path(@user, @event)
    patch user_event_path(@user, @event), params: { event: { title: "編集したテストイベント",
                                                              description: "テストイベントです。",
                                                              start_time: 2.days.from_now,
                                                              location: "カフェ",
                                                              category_id: @category.id } }
    assert_redirected_to root_path
    follow_redirect!
    assert_match "編集したテストイベント", response.body
  end
end
