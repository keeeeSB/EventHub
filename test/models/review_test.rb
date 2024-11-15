require "test_helper"

class ReviewTest < ActiveSupport::TestCase
  
  def setup
    @user = users(:Keisuke)
    @event = events(:event)
    @review = Review.new(body: "レビュー内容", rating: 3,
                         user_id: @user.id, event_id: @event.id)
  end

  test "bodyカラムのバリデーションのテスト" do
    @review.body = " "
    assert_not @review.valid?
  end

  test "ratingカラムのバリデーションのテスト" do
    @review.rating = " "
    assert_not @review.valid?
  end
end
