RailsAdmin.config do |config|
  config.parent_controller = 'ApplicationController'  # Deviseや認証システムに基づく場合

  config.authenticate_with do
    warden.authenticate! scope: :user
  end
  config.current_user_method(&:current_user)

  # 権限の確認
  config.authorize_with :cancan

  config.main_app_name = ["My App", "Admin"]
end
