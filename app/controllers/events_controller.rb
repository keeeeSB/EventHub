class EventsController < ApplicationController
  before_action :require_login, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_event, only: [:show, :edit, :update, :destroy]
  
  def upcoming
    @events = Event
                .upcoming
                .left_joins(:joins)
                .group(:id)
                .order('COUNT(joins.id) DESC')
    @users = User.all
  end

  def past
    @events = Event
                .past
                .left_joins(:reviews)
                .select('events.*, COALESCE(AVG(reviews.rating), 0) AS average_rating')
                .group('events.id')
                .order(average_rating: :desc)
  end

  def new
    @event = current_user.events.build
    @event.build_category
    @categories = Category.all
  end

  def create
    if event_params[:category_id].present?
      @event = current_user.events.build(event_params.except(:categpry_attributes))
    else
      @event = current_user.events.build(event_params)
    end
    if @event.save
      flash[:success] = "イベントを作成しました。"
      redirect_to root_path
    else
      flash.now[:danger] = "イベントを作成できませんでした。"
      render :new
    end
  end

  def show
    @reviews = @event.reviews.includes(:user).order(created_at: :desc)
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
      params.require(:event).permit(:title, :description, :start_time, :location,
                                    :user_id, :category_id, category_attributes: [:name])
    end

    def set_event
      @event = Event.find(params[:id])
    end
end
