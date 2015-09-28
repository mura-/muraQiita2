class Notification < ActiveRecord::Base
  def notify_comments=(comment)
    self.user_id = comment.user_id
    self.content = '新着のコメントがあります'
    # FIXME: エラーハンドリング
  end

end
