class FavoritesController < ApplicationController
  before_action :require_login, only: [:create, :destroy]

  def index
    @favorite_events = current_user.favorites.includes(:event).order('events.created_at DESC').map(&:event)
  end

  def create
    favorite = current_user.favorites.build(event_id: params[:event_id])
    if favorite.save
      flash[:success] = "お気に入りに登録しました。"
      redirect_to root_path
    else
      flash.now[:danger] = "お気に入りに登録できませんでした。"
    end
  end

  def destroy
    favorite = current_user.favorites.find(params[:id])
    favorite.destroy
    flash[:success] = "お気に入りを解除しました。"
    redirect_to root_path, status: :see_other
  end
end
