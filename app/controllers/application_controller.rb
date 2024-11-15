class ApplicationController < ActionController::Base
  include SessionsHelper

  def require_login
    unless logged_in?
      flash[:warning] = "ログインしてください。"
      redirect_to login_path
    end
  end

  def authenticate_admin!
    redirect_to root_path unless current_user&.admin?
  end
end
