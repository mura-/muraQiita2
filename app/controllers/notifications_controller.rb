class NotificationsController < ApplicationController
  def index
    @notifications = current_user.notifications.unreads
  end

  def update
    ### ここもできるだけ scaffold のコードの通り
    ### if @notification.update(notification_params)
    ###   redirect_to notifications_url
    ### else
    ###   render :index, alert: 'エラーメッセージ'
    ### end
    ### とした方が読みやすいと感じました.
    ### `notification = current_user.notifications.find(params[:id])`
    ### の部分も Rails の scaffold で生成される set_notification というメソッドに
    ### 切り出した方がよいかもしれませんね.
    notification = current_user.notifications.find(params[:id])
    notification.update(notification_params)
    redirect_to notifications_url
  end

  private
  def notification_params
    params.require(:notification).permit(:is_checked)
  end
end
