class NotificationsController < ApplicationController
  def index
    @notifications = Notification.unread_notifications(current_user)
  end

  def update
    notification = Notification.find(params[:id])
    notification.update(notification_params)
    redirect_to notifications_url
  end

  private
  def notification_params 
    params.require(:notification).permit(:is_checked)
  end
end
