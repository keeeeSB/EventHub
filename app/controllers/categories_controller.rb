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

  def show
    @category = Category.find(params[:id])
    @events = @category.events
                       .past
                       .left_joins(:reviews)
                       .select('events.*, COALESCE(AVG(reviews.rating), 0) AS average_rating')
                       .group('events.id')
                       .order('average_rating DESC')
  end
  

  private

    def category_params
      params.require(:category).permit(:name)
    end
end
 