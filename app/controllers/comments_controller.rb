class CommentsController < ApplicationController
  include NotificationHandlers

  ### StocksController にもレビューコメントを書いたのですが、コメントも `remote: true` で実装してもよいかもしれませんね

  def create
    ### コメントはログインしたユーザーしか投稿できないはずですので、
    ### current_user から comment を build した方がよいと思いました.
    ### tip はプライベートな `set_tip` を定義して、そこで @tip に代入しておけば、このメソッドのコードもよりすっきりしますね.
    tip = Tip.find(params[:tip_id])
    comment = tip.comments.build(comment_params)
    comment.user_id = current_user.id
    if comment.save
      flash.notice = 'コメントが投稿されました'
      ### 以下のコメントはコードを見れば何をしているか十分判断できましたので、不要かなと感じました
      ### コメントには、あえて Rails の定石を外れた書き方をしているか等の理由や「いいわけ」などを書くのがよいと思います。
      # 自分の記事でなければコメントがついたことを通知する
      if !is_my_tip?(tip)
        notify_comments(comment)
      end
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
