class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    if user.admin?
      can :manage, :all  # 管理者はすべての操作が可能
      can :access, :rails_admin  # 管理画面へのアクセス権
      can :manage, :dashboard    # ダッシュボードの管理権限
    else
      cannot :access, :rails_admin  # 一般ユーザーは管理画面にアクセス不可
    end
  end
end
