class ReviewsController < ApplicationController
  before_action :require_login, only: [:create, :update, :destroy]

  def create
    @review = current_user.reviews.build(review_params)
    if @review.save
      flash[:success] = "レビューを作成しました。"
    else
      flash.now[:danger] = "レビューを作成できませんでした。"
    end
    redirect_to user_event_path(@event.user, @event)
  end

  def update
    @review = current_user.reviews.find(params[:id])
    @event = @review.event
    if @review.update(review_params)
      flash[:success] = "レビューを更新しました。"
    else
      flash.now[:danger] = "レビューを更新できませんでした。"
    end
    redirect_to user_event_path(@event.user, @event)
  end

  def destroy
    @review = current_user.reviews.find(params[:id])
    @event = @review.event
    @review.destroy
    flash[:success] = "レビューを削除しました。"
    redierect_to user_event_path(@event.user, @event)
  end

  private

    def review_params
      params.require(:review).permit(:body, :rating, :user_id, :event_id)
    end
end
