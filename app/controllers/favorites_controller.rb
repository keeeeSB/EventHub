class FavoritesController < ApplicationController
  before_action :require_login, only: [:create, :destroy]

  def create
    favorite = current_user.favorites.build(event_id: params[:event_id])
    if favorite.save
      flash[:success] = "お気に入りに登録しました。"
    else
      flash.now[:danger] = "お気に入りに登録できませんでした。"
    end
    redirect_to root_path
  end

  def destroy
    favorite = current_user.favorites.find_by(id: params[:id])
    favorite.destroy
    flash[:success] = "お気に入りを解除しました。"
    redirect_to root_path
  end
end
