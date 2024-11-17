require "test_helper"

class CategoryTest < ActiveSupport::TestCase

  def setup
    @category = Category.new(name: "スポーツ")
  end

  test "nameカラムのバリデーションのテスト" do
    @category.name = " "
    assert_not @category.valid?
  end
end
