class Notification < ActiveRecord::Base
  include Rails.application.routes.url_helpers

  def notify_comments=(comment)
    self.user_id = comment.tip.user_id
    self.content = '新着のコメントがあります'
    self.reference_url = url_for(
      host: '192.168.33.100',
      port: '3000',
      controller: 'tips',
      action: 'show',
      id: comment.tip_id)
  end

  scope :unread_notifications, ->(user) { where(user_id: user, is_checked: false)}
end
