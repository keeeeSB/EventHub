class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] =  "ユーザー情報を更新しました。"
      redirect_to admin_users_path
    else
      flash.now[:danger] = "メールアドレスが既に使用されています。他のメールアドレスを入力してください。"
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:success] = "ユーザーを削除しました。"
    redirect_to admin_users_path
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :profile_image, :bio, :admin)
  end
end
