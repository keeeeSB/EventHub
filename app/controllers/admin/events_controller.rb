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
      redirect_to admin_events_path, notice: 'イベントが更新されました。'
    else
      render :edit
    end
  end

  def destroy
    @event = Event.find(params[:id])
    @event.destroy
    redirect_to admin_events_path, notice: 'イベントが削除されました。'
  end

  private

  def event_params
    params.require(:event).permit(:title, :description, :start_time, :location, :category_id)
  end
end
