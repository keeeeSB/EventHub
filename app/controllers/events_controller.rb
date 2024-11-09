class EventsController < ApplicationController
  before_action :require_login, only: [:new, :create, :show, :edit, :update, :destroy]
  before_action :set_event, only: [:show, :edit, :update, :destroy]
  
  def index
    @events = Event.all.order(created_at: :desc)
  end

  def new
    @event = current_user.events.build
  end

  def create
    @event = current_user.events.build(event_params)
    if @event.save
      flash[:success] = "イベントを作成しました。"
      redirect_to root_path
    else
      flash.now[:danger] = "イベントを作成できませんでした。"
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @event.update(event_params)
      flash[:success] = "イベント情報を更新しました。"
      redirect_to root_path
    else
      flash.now[:danger] = "イベント情報を更新できませんでした。"
      render :edit
    end
  end

  def destroy
    @event.destroy
    redirect_to root_path
  end

  private

    def event_params
      params.require(:event).permit(:title, :description, :start_time, :location)
    end

    def set_event
      @event = Event.find(params[:id])
    end
end
