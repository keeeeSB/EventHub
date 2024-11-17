require "test_helper"

class JoinCreationTest < ActionDispatch::IntegrationTest

  def setup
    @user       = users(:Keisuke)
    @event      = events(:event2)
  end

  test "他ユーザーの作成したイベントに参加" do
    log_in_as(@user)
    assert_redirected_to @user
    follow_redirect!

    assert_difference "Join.count", 1 do
      get root_path
      post user_event_joins_path(@user, @event), params: { join: { user_id: @user.id,
                                                                   event_id: @event.id } }
      assert_redirected_to root_path
      follow_redirect!
    end
  end

  test "参加イベントの取り消し" do
    log_in_as(@user)
    assert_redirected_to @user
    follow_redirect!

    assert_difference "Join.count", 1 do
      get root_path
      post user_event_joins_path(@user, @event), params: { join: { user_id: @user.id,
                                                                   event_id: @event.id } }
      assert_redirected_to root_path
      follow_redirect!
    end

    assert_difference "Join.count", -1 do
      delete user_event_join_path(@user, @event, Join.last)
      assert_redirected_to root_path
      follow_redirect!
    end
  end
end
