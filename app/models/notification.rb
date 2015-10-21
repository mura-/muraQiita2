class Notification < ActiveRecord::Base
  belongs_to :user
  scope :unreads, -> { where(is_checked: false)}
end
