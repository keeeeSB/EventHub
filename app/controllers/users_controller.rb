class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "登録できました。"
      redirect_to @user
    else
      flash.now[:danger] = "登録できませんでした。"
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation,
                                   :profile_image, :bio)
    end
end
