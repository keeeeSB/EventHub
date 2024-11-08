class ApplicationController < ActionController::Base
  include SessionsHelper

  def require_login
    unless logged_in?
      flash.now[:danger] = "ログインしてください。"
      redirect_to login_path
    end
  end
end
