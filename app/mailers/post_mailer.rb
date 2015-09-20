class PostMailer < ApplicationMailer
  def notification_comment(user, comment)
    @user = user
    @comment = comment
    mail to: user.email, subject: "[MuraQiita]あなたが投稿した記事にコメントがあります"
  end
end
