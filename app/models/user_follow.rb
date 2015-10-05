class UserFollow < ActiveRecord::Base
  belongs_to :user
  belongs_to :follow_user, class_name: 'User', foreign_key: 'follow_user'
end
