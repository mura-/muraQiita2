class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authenticate_user!

  ### tip が自分のものかどうかを判断するためだけのメソッドなので、Tip モデルで定義してもよいと思いました.
  ### Tip モデル側のコード例
  ### def owned_by?(user)
  ###   self.user == user
  ### end
  ### View 側のコード例
  ### - if @tip.owned_by?(current_user)
  def is_my_tip?(tip)
    current_user.present? and
    tip.user_id == current_user.id
  end
  helper_method :is_my_tip?

  def unread_notifications
    if user_signed_in?
      current_user.notifications.unreads
    end
  end
  helper_method :unread_notifications

end
