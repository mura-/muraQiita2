class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @user_follow = current_user.user_follows.find_by(follow_user: params[:id])
  end

  def mypage
    @my_tips = current_user.tips.limit(5)
    @stocked_tips = Tip.stocked(current_user).limit(5)
    @followed_tags = current_user.tags
    @follow_users = current_user.follow_users
    followed_users_ids = UserFollow.where(follow_user: current_user).pluck(:user_id)
    @followed_users = User.find(followed_users_ids)
    @comments = Comment.where(tip_id: @my_tips.pluck(:id)).limit(5)
  end
end
