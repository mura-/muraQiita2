class UserFollow < ActiveRecord::Base
  belongs_to :user
  belongs_to :user, foreign_key: "follow_user"
end