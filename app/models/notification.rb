class Notification < ActiveRecord::Base
  include Rails.application.routes.url_helpers

  scope :unread_notifications, ->(user) { where(user_id: user, is_checked: false)}
end
