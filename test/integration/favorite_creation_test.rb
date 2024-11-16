require "test_helper"

class FavoriteCreationTest < ActionDispatch::IntegrationTest

  def setup
    @user       = users(:Keisuke)
    @event      = events(:event)
  end

  test "お気に入りの追加のテスト" do
    log_in_as(@user)
    assert_redirected_to @user
    follow_redirect!

    assert_difference "Favorite.count", 1 do
      get root_path
      post user_event_favorites_path(@user, @event), params: { favorite: { user_id: @user.id,
                                                                           event_id: @event.id } }
      assert_redirected_to root_path
      follow_redirect!
    end
  end

  test "お気に入りの取り消しのテスト" do
    log_in_as(@user)
    assert_redirected_to @user
    follow_redirect!

    assert_difference "Favorite.count", 1 do
      get root_path
      post user_event_favorites_path(@user, @event), params: { favorite: { user_id: @user.id,
                                                                           event_id: @event.id } }
      assert_redirected_to root_path
      follow_redirect!
    end

    assert_difference "Favorite.count", -1 do
      delete user_event_favorite_path(@user, @event, Favorite.last)
      assert_redirected_to root_path
      follow_redirect!
    end
  end
end
