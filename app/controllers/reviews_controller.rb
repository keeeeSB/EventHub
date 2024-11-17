class ReviewsController < ApplicationController
  before_action :require_login, only: [:create, :edit, :update, :destroy]
  before_action :set_review, only: [:edit, :update, :destroy]

  def create
    @event = Event.find(params[:event_id])
    @review = current_user.reviews.build(review_params)
    if @review.save
      flash[:success] = "レビューを作成しました。"
      redirect_to user_event_path(@event.user, @event)
    else
      flash.now[:danger] = "レビューを作成できませんでした。"
    end
  end

  def edit
    @event = @review.event
  end

  def update
    @event = @review.event
    if @review.update(review_params)
      flash[:success] = "レビューを更新しました。"
      redirect_to user_event_path(@event.user, @event)
    else
      flash.now[:danger] = "レビューを更新できませんでした。"
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @event = @review.event
    @review.destroy
    flash[:success] = "レビューを削除しました。"
    redirect_to user_event_path(@event.user, @event), status: :see_other
  end

  private

    def review_params
      params.require(:review).permit(:body, :rating).merge(
        user_id: current_user.id, event_id: params[:event_id]
      )
    end

    def set_review
      @review = current_user.reviews.find(params[:id])
    end
end
