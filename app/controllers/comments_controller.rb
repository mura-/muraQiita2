class CommentsController < ApplicationController
  def create
    tip = Tip.find(params[:tip_id])
    comment = tip.comments.build(comment_params)
    comment.user_id = current_user.id
    if comment.save
      flash.notice = 'コメントが投稿されました'
      PostMailer.notification_comment(current_user, comment).deliver if !is_my_tip?(tip) 
    else
      flash.alert = 'コメントが投稿できませんでした。もう一度お試しください。'
    end
      redirect_to tip_url(tip) 
  end
  
  private
  def comment_params
    params.require(:comment).permit(:content, :tip_id)
  end
end
