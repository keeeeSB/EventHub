class JoinsController < ApplicationController
  before_action :require_login, only: [:create, :destroy]

  def index
    @join_events = current_user.joins.includes(:event).order('events.created_at DESC').map(&:event)
  end

  def create
    join = current_user.joins.build(event_id: params[:event_id])
    if join.save
      flash[:success] = "参加申し込みが完了しました。"
      redirect_to root_path
    else
      flash.now[:danger] = "参加申し込みができませんでした。"
    end
  end

  def destroy
    join = current_user.joins.find_by(params[:id])
    join.destroy
    flash[:success] = "参加申し込みを取り消しました。"
    redirect_to root_path, status: :see_other
  end
end
