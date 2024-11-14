class AddAdminToUsers < ActiveRecord::Migration[7.0]
  def change
    # 既に存在するadminカラムに対してデフォルト値を設定
    change_column_default :users, :admin, false
    # 既存のレコードに対してnull: false を設定
    change_column_null :users, :admin, false
  end
end
