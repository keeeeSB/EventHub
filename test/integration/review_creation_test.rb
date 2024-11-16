require "test_helper"

class ReviewCreationTest < ActionDispatch::IntegrationTest

  def setup
    @user       = users(:Keisuke)
    @event      = events(:event2)
    @other_user = users(:Natsuki)
    @review     = reviews(:review)
  end

  test "レビュー作成のテスト" do
    log_in_as(@user)
    assert_redirected_to @user
    follow_redirect!

    get past_user_events_path(@other_user)
    assert_response :success

    get user_event_path(@other_user, @event)
    assert_response :success

    assert_difference "Review.count", 1 do
      post user_event_reviews_path(@user, @event), params: { review: { body: "とてもよかったです。",
                                                                       rating: 4 } }
      assert_redirected_to user_event_path(@other_user, @event)
      follow_redirect!
      assert_match "とてもよかったです。", response.body
    end
  end

  test "レビュー編集のテスト" do
    log_in_as(@user)
    assert_redirected_to @user
    follow_redirect!

    get past_user_events_path(@other_user)
    assert_response :success

    get user_event_path(@other_user, @event)
    assert_response :success
    
    get edit_user_event_review_path(@user, @event, @review)
    assert_response :success
    patch user_event_review_path(@user, @event, @review), params: { review: { body: "普通でした。",
                                                                              rating: 3 } }
    assert_redirected_to user_event_path(@other_user, @event)
    follow_redirect!
    assert_match "普通でした。", response.body
  end

  test "レビュー削除のテストを追加" do
    log_in_as(@user)
    assert_redirected_to @user
    follow_redirect!

    get past_user_events_path(@other_user)
    assert_response :success

    get user_event_path(@other_user, @event)
    assert_response :success

    assert_difference "Review.count", 1 do
      post user_event_reviews_path(@user, @event), params: { review: { body: "とてもよかったです。",
                                                                       rating: 4 } }
      assert_redirected_to user_event_path(@other_user, @event)
      follow_redirect!
      assert_match "とてもよかったです。", response.body
    end

    assert_difference "Review.count", -1 do
      delete user_event_review_path(@user, @event, Review.last)
      assert_redirected_to user_event_path(@other_user, @event)
      follow_redirect!
      assert_no_match "とてもよかったです。", response.body
    end
  end
end
