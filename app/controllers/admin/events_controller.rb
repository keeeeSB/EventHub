class Admin::EventsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @events = Event.all
  end

  def show
    @event = Event.find(params[:id])
  end

  def edit
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])
    if @event.update(event_params)
      flash[:success] = "イベントを更新しました。"
      redirect_to admin_events_path
    else
      render :edit
    end
  end

  def destroy
    @event = Event.find(params[:id])
    @event.destroy
    flash[:success] = "イベントを削除しました。"
    redirect_to admin_events_path
  end

  private

  def event_params
    params.require(:event).permit(:title, :description, :start_time, :location, :category_id)
  end
end
