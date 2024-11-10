class ReviewsController < ApplicationController
  before_action :require_login, only: [:create, :update, :destroy]

  def create
    @review = current_user.reviews.build(review_params)
    if @review.save
      flash[:success] = "レビューを作成しました。"
    else
      flash.now[:danger] = "レビューを作成できませんでした。"
    end
    redirect_to user_event_path(@review.event) # 最終的にそのイベント詳細ページへ
  end

  def update
    @review = current_user.reviews.find_by(parsms[:id])
    if @review.update(review_params)
      flash[:success] = "レビューを更新しました。"
    else
      flash.now[:danger] = "レビューを更新できませんでした。"
    end
    redirect_to root_path
  end

  def destroy
    @review = current_user.reviews.find_by(params[:id])
    @review.destroy
    flash[:success] = "レビューを削除しました。"
    redierct_to root_path
  end

  private

    def review_params
      params.require(:review).permit(:body, :rating, :event_id)
    end
end
