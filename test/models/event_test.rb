require "test_helper"

class EventTest < ActiveSupport::TestCase

  def setup
    @user = users(:Keisuke)
    @category = categories(:sports)
    @event = Event.new(title: "タイトル", description: "説明文", start_time: 2.days.from_now,
                       location: "場所", user_id: @user.id, category_id: @category.id)
  end

  test "titleカラムのバリデーションのテスト" do
    @event.title = " "
    assert_not @event.valid?
  end

  test "descriptionカラムのバリデーションのテスト" do
    @event.description = " "
    assert_not @event.valid?
  end

  test "start_timeカラムのバリデーションのテスト" do
    @event.start_time = " "
    assert_not @event.valid?
  end

  test "locationカラムのバリデーションのテスト" do
    @event.location = " "
    assert_not @event.valid?
  end
end
