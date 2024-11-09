class CategoriesController < ApplicationController
  before_action :require_login, only: [:create]

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:success] = "カテゴリーを作成しました。"
      redirect_to root_path
    else
      flash.now[:danger] = "カテゴリーを作成できませんでした。"
      render :new
    end
  end

  private

    def category_params
      params.require(:category).permit(:name)
    end
end
 