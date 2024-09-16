class NotificationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @notifications = Notification.all
    render json: @notifications
  end

  def show
    @notification = Notification.find(params[:id])
    render json: @notification
  end

  def new
    @notification = Notification.new
  end

  def create
    @notification = Notification.new(notification_params)
    if @notification.save
      render json: @notification, status: :created
    else
      render json: @notification.errors, status: :unprocessable_entity
    end
  end

  def edit
    @notification = Notification.find(params[:id])
  end

  def update
    @notification = Notification.find(params[:id])
    if @notification.update(notification_params)
      render json: @notification
    else
      render json: @notification.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @notification = Notification.find(params[:id])
    @notification.destroy
    head :no_content
  end

  private

  def notification_params
    params.require(:notification).permit(:user_id, :message, :read_at)
  end
end
