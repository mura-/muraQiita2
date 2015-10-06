class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authenticate_user!

  def is_my_tip?(tip)
    current_user.present? and
    tip.user_id == current_user.id
  end
  helper_method :is_my_tip?

  def unread_notifications
    if user_signed_in? 
      Notification.unread_notifications(current_user)
    end
  end
  helper_method :unread_notifications

end
